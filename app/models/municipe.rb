class Municipe < ApplicationRecord
  AGE_LIMIT_IN_YEARS = 120
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  include Addressable

  has_one_attached :picture do |attachable|
    attachable.variant :thumb, resize_to_limit: [800, 80]
    attachable.variant :square, resize_to_limit: [200, 200]
    attachable.variant :portrait, resize_to_limit: [400, 200]
    attachable.variant :landscape, resize_to_limit: [200, 400]
  end

  validates_presence_of :full_name, :document_cpf, :document_cns, :email, :birthdate, :ddi, :ddd, :phone, :status
  validate :validate_picture_mime_type, :validate_birthdate, :validate_document_cpf, :validate_document_cns
  validates :full_name, presence: true, length: { minimum: 3 }, if: :full_name?
  validates :ddi, presence: true,
                  length: { minimum: 3, maximum: 3 },
                  if: :ddi?
  validates :ddd, presence: true,
                  length: { minimum: 2, maximum: 2 },
                  if: :ddd?
  validates :phone, presence: true,
                    length: { minimum: 9 },
                    if: :phone?
  validates :email, presence: true,
                    uniqueness: { allow_blank: false, case_sensitive: false },
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    if: :email?
  validates :document_cpf, presence: true,
                          uniqueness: { :allow_blank: false, :case_sensitive: false },
                          length: { maximum: 11, minimum: 11 },
                          if: :document_cpf?
  validates :document_cns, presence: true,
                          uniqueness: { :allow_blank: false, :case_sensitive: false },
                          length: { maximum: 15, minimum: 15 },
                          if: :document_cns?

  enum :status, active: "active", inactive: "inactive"

  before_save :standardize_attributes

  after_create :side_effect_after_create
  after_update :side_effect_after_update, if: -> { self.saved_change_to_status? }

  scope :actives, -> { where(status: "active") }

  scope :inactives, -> { where(status: "inactive") }

  audited
  include AlgoliaSearch

  algoliasearch disable_indexing: Rails.env.test? do
    attribute :full_name
    attribute :birthdate
    attribute :document_cpf
    attribute :document_cns
    attribute :phone
    attribute :email
    attribute :status
    attribute :formatted_phone

    attribute :public_addresses do
      addresses.map do |add|
        {
          street_name: add.street_name,
          neighborhood: add.neighborhood,
          city: add.city,
          state: add.state,
          complement: add.complement,
          ibge_code: add.ibge_code
        }
      end
    end
  end

  def picture_variants
    %w[thumb square portrait landscape]
  end

  def name
    full_name
  end

  def formatted_phone
    "#{ddi}#{ddd}#{phone}"
  end

  private

  def standardize_attributes
    self.document_cpf = self.document_cpf.to_s.delete('^0-9')
    self.document_cns = self.document_cns.to_s.delete('^0-9')
    self.phone = self.phone.to_s.delete('^0-9')
    self.ddi = "+#{self.ddi.to_s.delete('^0-9')}"
    self.ddd = self.ddd.to_s.delete('^0-9')
    self.birthdate = self.birthdate.to_date
  end

  def validate_birthdate
    errors.add(:birthdate, :required) unless self.birthdate.present?
    errors.add(:birthdate, :invalid) unless Date.parse(self.birthdate.to_s)
    errors.add(:birthdate, :invalid_format) unless self.birthdate.acts_like?(:date)
    errors.add(:birthdate, :can_t_be_after_today) if self.birthdate.to_date >= Date.today
    errors.add(:birthdate, :age_out_of_limit) if TimeDifference.between(self.birthdate.to_date, Date.today).in_years > AGE_LIMIT_IN_YEARS
  end

  def validate_document_cpf
    errors.add(:document_cpf, :invalid_format) unless CPF.valid?(self.document_cpf, strict: true).present?
    errors.add(:document_cpf, :invalid) unless CpfService.new(self.document_cpf, self.birthdate).fetch.present?
  end

  def validate_document_cns
    errors.add(:document_cns, :required) unless self.document_cns.present?
    errors.add(:document_cns, :invalid) unless CnsService.new(self.document_cns).is_valid?.present?
  end

  def validate_picture_mime_type
    if picture.attached? and !picture.content_type.in?(%w(image/png image/jpg image/jpeg))
      errors.add(:picture, :invalid_format)
    end
  end

  protected

  def side_effect_after_create
    SmsJob.perform_later(self.formatted_phone, "Your registration was carried out at #{Figaro.env.application_name}")
    MunicipeMailer.on_create(self).deliver_later
  end

  def side_effect_after_update
    SmsJob.perform_later(self.formatted_phone, "Your details have been updated on #{Figaro.env.application_name}")
    MunicipeMailer.on_update(self).deliver_later
  end
end
