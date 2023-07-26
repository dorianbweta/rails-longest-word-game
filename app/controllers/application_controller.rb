class ApplicationController < ActionController::Base
  # Added manually to solve the “can't verify CSRF token authenticity” problem.
  protect_from_forgery with: :null_session
end
