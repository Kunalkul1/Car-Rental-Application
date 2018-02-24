class ExampleMailer < ApplicationMailer
  default from: "carrentaloodd2017@gmail.com"

  def sample_email(member)
    @member = member
    mail(to: @member.email, subject: 'Your car on carrental is available!')
  end
end
