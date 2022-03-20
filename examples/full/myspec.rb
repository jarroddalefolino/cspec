# frozen_string_literal: true

require 'cspec'
require 'logging'

# Logger setup
class Object
  def logger_info
    "#{self.class}##{__callee__} (#{object_id})"
  end
end

class MyLogger
  def self.instance
    return @logger if @logger

    @logger = Logging.logger($stdout)
    @logger.level = ENV['LOG_LEVEL']&.to_sym || :warn
    @logger.add_appenders \
      Logging.appenders.stdout,
      Logging.appenders.file("#{Time.now.strftime('%Y%m%d')}.log")
    @logger
  end
end

result = CSpec::Runner.run!("#{Dir.pwd}/specs.csv")
exit result ? 0 : 1
