class HomeController < ApplicationController
  def index
    redirect_to controller: 'assessments', action: 'new'
  end
end
