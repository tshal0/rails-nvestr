# Portfolio Controller
# 


class PortfoliosController < ApplicationController

  
  # Load
  # Should have access to a user ID in the session data.
  def load
    
    # Get portfolio data
    @portfolio = Portfolio.find_by(user_id: session[:user_id])
    @positions = Position.where(portfolio_id: @portfolio.id)
    @stocks = []
    @positions.each do |pos|
      @stocks << Stock.find(pos.stock_id)
    end
    @position_stock = @positions.zip(@stocks)
  	@headers = ['Company Name', "Symbol", "Price", "Amount", "Value","Actions"]


    # Load page

    respond_to do |format|

      format.html # load.html.erb

    end

  end

  def position_history
    @position = Position.find(params[:position_id])
    @trades = Trade.where(position_id: @position.id)

    respond_to do |format|

      format.js {}

    end
  end

  def save_position

  end

  def show
    @user = User.find_by(user_name: params[:id])
    @current_user = User.find(session[:user_id])
    @portfolio = Portfolio.find_by(user_id: @user.id)
    @positions = Position.where(portfolio_id: @portfolio.id)
    @stocks = []
    @positions.each do |pos|
      @stocks << Stock.find(pos.stock_id)
    end
    @position_stock = @positions.zip(@stocks)
    @headers = ['Company Name', "Symbol", "Price", "Amount", "Value","Actions"]


    respond_to do |format|
      format.html { render :template => 'portfolios/load'}
    end

  end
  
end













