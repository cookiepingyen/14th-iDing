# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@iding.website'
  layout 'mailer'
end
