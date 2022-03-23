class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  require "json"

  def home
  end

end
