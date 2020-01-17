# frozen_string_literal: true

module ExplicitQueryCondition
  module ActiveRecordPatch
    def self.setup(base)
      base::const_get(:ActiveRecord_Relation)
        .prepend(::ExplicitQueryCondition::ActiveRecordPatch::ActiveRecord_Relation)

      base::const_get(:ActiveRecord_Associations_CollectionProxy)
        .prepend(::ExplicitQueryCondition::ActiveRecordPatch::ActiveRecord_Associations_CollectionProxy)
    end

    def self.missing_condition_warning(where_values_hash, klass)
      return if where_values_hash.has_key?(klass.explicit_condition_column.to_s)

      ExplicitQueryCondition.logger.warn <<~WARN
        \nWARNING: the query doesn't contain an explicit condition for "#{klass}##{klass.explicit_condition_column}" attribute.
      WARN
    end

    module ActiveRecord_Relation
      def delete_all
        ::ExplicitQueryCondition::ActiveRecordPatch.missing_condition_warning(where_values_hash, klass)
        super
      end

      def update_all(*args)
        ::ExplicitQueryCondition::ActiveRecordPatch.missing_condition_warning(where_values_hash, klass)
        super
      end

      def load(&block)
        ::ExplicitQueryCondition::ActiveRecordPatch.missing_condition_warning(where_values_hash, klass)
        super
      end
    end

    module ActiveRecord_Associations_CollectionProxy
      def initialize(klass, association)
        super
        ::ExplicitQueryCondition::ActiveRecordPatch.missing_condition_warning(where_values_hash, klass)
      end
    end
  end
end
