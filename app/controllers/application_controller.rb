require 'design_system/errors.rb'

class ApplicationController < ActionController::Base
  before_action :setup_error_messages

  private

  def setup_error_messages
    @errors = DesignSystem::Errors.new
  end
end
