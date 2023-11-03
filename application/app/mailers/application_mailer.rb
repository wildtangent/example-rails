# frozen_string_literal: true

# ApplicationMailer - base mailer abstraction
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
