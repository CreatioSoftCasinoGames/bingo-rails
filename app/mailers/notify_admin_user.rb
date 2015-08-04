class NotifyAdminUser < ActionMailer::Base
  default from: "bugs@creatiosoft.com"

  def send_error_mail(error)
  	@productionRecievers = "rishabh@creatiosoft.com, bugcreatiosoft@gmail.com"
  	@subject 	= "Error while - "+error.bug_type
  	@body 		=	"The following message will help you more to track the issue - \n\n"+error.exception
  	mail(to: @productionRecievers, subject: @subject, body: @body)
  end

end
