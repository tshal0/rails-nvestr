# Portfolio Controller
# 


class PortfoliosController < ApplicationController

  
  # Load
  # Should have access to a user ID in the session data.
  def load
    
    # Get portfolio data

    # Load page

    respond_to do |format|

      format.html # load.html.erb

    end

  end
  
end
