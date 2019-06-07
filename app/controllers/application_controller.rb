require 'design_system/errors.rb'

class ApplicationController < ActionController::Base
  before_action :setup_error_messages

private

  def setup_error_messages
    @errors = DesignSystem::Errors.new
  end

  def checkboxes_params_to_list(checkboxes_response_hash)
    # not sure why this is needed exactly - TODO investigate - this method is documentation as much as anything
    checkboxes_response_hash.keys
  end
end
