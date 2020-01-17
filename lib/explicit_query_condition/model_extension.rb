# frozen_string_literal: true

module ExplicitQueryCondition
  module ModelExtension
    def self.included(base)
      base.class_attribute :explicit_condition_column

      ::ExplicitQueryCondition::ActiveRecordPatch.setup(base)
    end
  end
end
