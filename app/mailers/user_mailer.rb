class UserMailer < ApplicationMailer
	default :from => "寄件人名字 <noreply@example.org>"

	def notify_event(user, event)
	    @event = event
	    mail(:to => user.email, :subject => "New Event")
	end
end
