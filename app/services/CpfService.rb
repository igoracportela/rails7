class CpfService
  attr_accessor :document_cpf, :birthdate

  def initialize(document_cpf, birthdate)
    self.document_cpf = document_cpf
    self.birthdate = birthdate
  end

  def fetch
    return true if Rails.env.test?

    url = "#{Figaro.env.cpf_api_host}v2/cpf/?cpf=#{self.document_cpf}&data=#{formatted_birthdate}&token=#{Figaro.env.cpf_api_token}"
    request = Rails.cache.fetch([self.document_cpf, formatted_birthdate, 'CpfService'], expires_in: 1.hour) do
      RestClient.get(url).to_s
    end

    request = Oj.load(request)

    return nil unless request['return'].to_s.downcase.eql?('ok')

    standardize_result(request['result'])
  rescue RestClient::ExceptionWithResponse => e
    raise "Fail on fetch document cpf - #{e.response}"
  end

  private

  def formatted_birthdate
    self.birthdate.to_date.strftime('%d/%m/%Y')
  end

  def standardize_result(request)
    {
      document_cpf: request['numero_de_cpf'],
      full_name: request['nome_da_pf'],
      birthdate: request['data_nascimento'],
      registration_status: request['situacao_cadastral'],
      emission_date: request['data_inscricao']
    }
  end
end