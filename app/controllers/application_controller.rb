class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_nav
  
  private
  
  def get_nav
    @nav = NavItem.order("priority");
  end
end
