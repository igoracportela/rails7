class Address < ApplicationRecord
  belongs_to :ownereable, polymorphic: true, primary_key: :id, optional: false

  validates_presence_of ownereable, :zip_code, :street_name, :number, :neighborhood, :city, :state
  validates :street_name, presence: true, length: { minimum: 5 }, if: :street_name?
  validates :neighborhood, presence: true, length: { minimum: 5 }, if: :neighborhood?
  validates :zip_code, presence: true, length: { maximum: 8, minimum: 8 }, if: :zip_code?
  validates :state, presence: true, length: { maximum: 2, minimum: 2 }, if: :state?

  audited

  enum state: {
    ac: 'Acre',
    al: 'Alagoas',
    ap: 'Amapá',
    am: 'Amazonas',
    ba: 'Bahia',
    ce: 'Ceará',
    df: 'Distrito Federal',
    es: 'Espírito Santo',
    go: 'Goiás',
    ma: 'Maranhão',
    mt: 'Mato Grosso',
    ms: 'Mato Grosso do Sul',
    mg: 'Minas Gerais',
    pa: 'Pará',
    pb: 'Paraíba',
    pr: 'Paraná',
    pe: 'Pernambuco',
    pi: 'Piauí',
    rj: 'Rio de Janeiro',
    rn: 'Rio Grande do Norte',
    rs: 'Rio Grande do Sul',
    ro: 'Rondônia',
    sc: 'Santa Catarina',
    se: 'Sergipe',
    sp: 'São Paulo',
    to: 'Tocantins'
  }, _suffix: true

  def formatted_address
    "#{street_name}, nº#{number}, #{neighborhood}. #{city}-#{state.to_s.upcase}. #{ibge_code.present? ? "Ibge: #{ibge_code}" : '' }"
  end

end
