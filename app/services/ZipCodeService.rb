class ZipCodeService
  attr_accessor :zip_code

  def initialize(zip_code)
    self.zip_code = zip_code
  end

  def fetch
    url = "#{Figaro.env.zip_code_api_host}v2/cep3/?cep=#{self.zip_code}&token=#{Figaro.env.zip_code_api_token}"
    request = Rails.cache.fetch([self.zip_code, 'ZipCodeService'], expires_in: 1.hour) do
      RestClient.get(url).to_s
    end

    request = Oj.load(request)

    return nil unless request['return'].to_s.downcase.eql?('ok')

    standardize_result(request['result'])
  rescue RestClient::ExceptionWithResponse => e
    raise "Fail on fetch zip code - #{e.response}"
  end

  private

  def standardize_result(request)
    {
      street_name: request['logradouro'],
      neighborhood: request['bairro'],
      state: request['uf'].to_s.downcase,
      city: request['localidade'],
      zip_code: request['cep'].to_s.delete('^0-9')
    }
  end
end