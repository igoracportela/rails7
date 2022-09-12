class SmsJob < ApplicationJob
  queue_as :default

  def perform(number, message)
    request = RestClient.post(Figaro.env.sms_api_host, { phone: number, message: message, key: Figaro.env.sms_api_token }, {})
    Oj.load(request)
  end
end
