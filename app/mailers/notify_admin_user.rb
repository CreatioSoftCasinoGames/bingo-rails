class NotifyAdminUser < ActionMailer::Base
  default from: "bugs@creatiosoft.com"

  def send_error_mail(error)
  	mail(to: "rishabh@creatiosoft.com", subject: error.bug_type, body: error.exception)
  end

end
