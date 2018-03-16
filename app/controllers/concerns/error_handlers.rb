# frozen_string_literal: true

module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    class UnauthorizedError < StandardError; end
    rescue_from UnauthorizedError do |e|
      message = (e.message == e.class.to_s) ? 'You are not allow to do this action' : e.message

      render json: {
        type: 'permission_denied',
        message: message
      }, status: :forbidden
    end
  end
end
