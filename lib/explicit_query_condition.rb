# frozen_string_literal: true

require "explicit_query_condition/version"
require "explicit_query_condition/active_record_patch"
require "explicit_query_condition/model_extension"

module ExplicitQueryCondition
  @logger = nil

  class << self
    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def logger=(logger)
      @logger = logger
    end
  end
end
