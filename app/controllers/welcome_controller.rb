class WelcomeController < ApplicationController
  def index
    
  end

  def say
    
  end

  def ajax
  	
  end

  def ajaxtest
  	respond_to do |format|
			format.html { render :layout => false } # ajaxtest.html.erb
			format.js
			format.json { render :json => {:title => Time.now}}
		end
  end

end
