class UserMailer < ActionMailer::Base
	default :from => "info@mentorhip.com",
		:cc => "info@mentorhip.com"
  
  def registration_confirmation(user)
  	@user = user
  	mail(:to => user.email, :subject => "Thanks for Registering!")
  end
  
  def sent(from , to , subject  , content)	
	@content = content
	mail(:from => from, :to => to , :subject => subject)	  
  end
  
  def send_info(from, to, cc = nil, user, course)
	  @requestor = to
	  cc = cc.nil? ? "info@mentorhip.com" : cc + ", info@mentorhip.com" 
	  @user=user
	  @course=course
	  @message = ' MentorHip: Your Order with '+ @user.name + ' is being processed'
	mail(:from => from, :to => to , :cc => cc, :subject => @message)	  
  end
  
  def invitation_email(from , to, user)	
	
	@user=user
	@message = ' MentorHip: Invitation '
	mail(:from => from, :to => to , :subject => @message )	  
  end
  
end
