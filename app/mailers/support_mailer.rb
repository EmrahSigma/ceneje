class SupportMailer < ApplicationMailer
    def contact_support(title, description)
        @title = title
        @description = description
        mail(to: "emrah.sekic@scv.si", subject: "Support Request: #{@title}")
      end
end
