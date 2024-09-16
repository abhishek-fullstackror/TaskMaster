class HomeController < ApplicationController
  def index
    @tasks = Task.includes(:user).all
  end
end
