require "logger"

module Webrat
  module Logging #:nodoc:

    def debug_log(message) # :nodoc:
      return unless logger
      logger.debug message
    end

    def logger # :nodoc:
      case Webrat.configuration.mode
      when :rails
        if Rails.version.to_f >= 3.0
          Rails.logger
        else 
          defined?(RAILS_DEFAULT_LOGGER) ? RAILS_DEFAULT_LOGGER : nil
        end
      when :merb
        ::Merb.logger
      else
        @logger ||= ::Logger.new("webrat.log")
      end
    end

  end
end
