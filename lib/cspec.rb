# frozen_string_literal: true

require 'cspec/version'
require 'cspec/runner'
require 'cspec/loader'
require 'cspec/result'
require 'cspec/code_exec'
require 'cspec/data_type'
require 'cspec/validator'
require 'cspec/results_outputter'

require 'csv'

module CSpec
  def self.root
    File.dirname __dir__
  end
end
