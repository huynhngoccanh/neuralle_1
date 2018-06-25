class ContactFormMailer < ApplicationMailer
  def contact_form_email(params)
    raw_options = params['service_options'] || []
    service_options = Refinery::ServiceOptions::ServiceOption.find(raw_options.map{|option| option.to_i })
    @service_option_description = service_options.map do |option|
      option.title
    end.join(', ')
    @service_option_description = 'None selected' if service_options.empty?
    @params = params.except('to')
    mail(to: params['to'], subject: 'Someone wants to talk to you')
  end
end
