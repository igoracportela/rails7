module ApplicationHelper
  def phone_format(phone)
    "#{phone.at(0..2)} (#{phone.at(3..4)}) #{phone.at(5..phone.size)}"
  end

  def cpf_format(cpf)
    CPF.new(cpf).formatted
  end

  def parse_timestamp(timestamp)
    timestamp.to_time.strftime('%d/%m/%Y às %H:%M:%S') rescue timestamp
  end
end
