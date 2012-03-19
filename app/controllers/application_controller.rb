class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_nav_pages
  
  private
  
  def get_nav_pages
    @nav_pages = Page.all;
  end
end
