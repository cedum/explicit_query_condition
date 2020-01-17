# frozen_string_literal: true

RSpec.describe ExplicitQueryCondition::ModelExtension do
  with_model :Product do
    table do |t|
      t.string :name
      t.string :deleted_at
    end

    model do
      include ExplicitQueryCondition::ModelExtension
      self.explicit_condition_column = :deleted_at
    end
  end

  before do
    Product.create!
  end

  context 'with the explicit condition' do
    shared_examples 'doesn\'t log the warning' do
      let(:logger) { ExplicitQueryCondition.logger }
      before { allow(logger).to receive(:warn) }

      it 'doesn\'t log a warning' do
        subject
        expect(logger).to_not have_received(:warn)
      end
    end

    let(:query_scope) { Product.where(deleted_at: Time.now) }

    context '.first' do
      subject { query_scope.first }
      include_examples 'doesn\'t log the warning'
    end

    context '.all' do
      subject { query_scope.load }
      include_examples 'doesn\'t log the warning'
    end

    context '.delete_all' do
      subject { query_scope.delete_all }
      include_examples 'doesn\'t log the warning'
    end

    context '.destroy_all' do
      subject { query_scope.destroy_all }
      include_examples 'doesn\'t log the warning'
    end

    context '.update_all' do
      subject { query_scope.update_all(name: 'test') }
      include_examples 'doesn\'t log the warning'
    end
  end

  context 'without the explicit condition' do
    shared_examples 'logs the warning' do
      let(:warning_msg) do
        <<~WARN
          \nWARNING: the query doesn't contain an explicit condition for "Product#deleted_at" attribute.
        WARN
      end

      let(:logger) { ExplicitQueryCondition.logger }
      before { allow(logger).to receive(:warn) }

      it 'logs a warning' do
        subject
        expect(logger).to have_received(:warn).once.with(warning_msg)
      end
    end

    context '.first' do
      subject { Product.first }
      include_examples 'logs the warning'
    end

    context '.all' do
      subject { Product.all.load }
      include_examples 'logs the warning'
    end

    context '.delete_all' do
      subject { Product.delete_all }
      include_examples 'logs the warning'
    end

    context '.destroy_all' do
      subject { Product.destroy_all }
      include_examples 'logs the warning'
    end

    context '.update_all' do
      subject { Product.update_all(name: 'test') }
      include_examples 'logs the warning'
    end
  end
end
