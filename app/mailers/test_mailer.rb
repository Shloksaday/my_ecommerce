class TestMailer < ApplicationMailer
    def smtp_test
      mail(
        to: ENV["GMAIL_USERNAME"],
        subject: "SMTP TEST",
        body: "If you got this, SMTP works."
      )
    end
end
  