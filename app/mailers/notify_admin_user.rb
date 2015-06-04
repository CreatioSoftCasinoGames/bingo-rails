class NotifyAdminUser < ActionMailer::Base
  default from: "bugs@creatiosoft.com"

  def send_error_mail(error)
  	# @localRecivers = "rishabh@creatiosoft.com, neeraj@creatiosoft.com"
  	@productionRecievers = "amrendra@creatiosoft.com, neeraj@creatiosoft.com, rishabh@creatiosoft.com, narendra@creatiosoft.com, jagadheeswarreddy@creatiosoft.com, manishkumar@creatiosoft.com"
  	@subject 	= "Error while - "+error.bug_type
  	@body 		=	"The following message will help you more to track the issue - \n\n"+error.exception
  	mail(to: @productionRecievers, subject: @subject, body: @body)
  end

end
