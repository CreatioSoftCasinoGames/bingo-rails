class NotifyAdminUser < ActionMailer::Base
  default from: "bugs@creatiosoft.com"

  def send_error_mail(error)
  	p "----------------------Called NotifyAdminUser---------------------"
  	p error.exception
  	mail(to: "rishabh@creatiosoft.com", subject: error.exception)
  end

end
