class MunicipeMailer < ApplicationMailer
  default :from => Figaro.env.application_no_reply_mail

  def on_create(municipe)
    @municipe = municipe
    mail(:to => @municipe.email, :subject => "Your registration was carried out at #{Figaro.env.application_name}")
  end

  def on_update(municipe)
    @municipe = municipe
    mail(:to => @municipe.email, :subject => "Your details have been updated on #{Figaro.env.application_name}")
  end
end
