require 'spec_helper'
# require 'rails/all'
# require 'rspec/rails'

require './spec/rails_stub.rb'
require './spec/logger_stub.rb'
require './spec/context_log_stub.rb'


require './lib/context_logger.rb'

require 'active_support/core_ext/hash'
require 'ostruct'

describe ContextLogger do
  context 'self.options' do
    it 'expect options to be equal described_class::DEFAULTS' do
      expect(described_class.options).to eq(described_class::DEFAULTS)
    end
  end

  context 'self.setup' do
    it 'expect modify options' do
      described_class.setup(context: :publish)
      expect(described_class.options).to eq(described_class::DEFAULTS.merge(context: :publish))

      described_class.setup(context: :not_publish, another_key: :another_value)
      expect(described_class.options).to eq(described_class::DEFAULTS.merge(context: :not_publish, another_key: :another_value))
    end
  end


  context 'self.set_destinations' do
    it 'ALL_DESTINATIONS' do
      described_class.set_destinations(:all)
      expect(described_class.destinations).to eq(described_class::ALL_DESTINATIONS)
    end

    it 'write_rails_log and write_context_log' do
      described_class.set_destinations(write_rails_log: true, write_context_log: true)
      expect(described_class.destinations).to eq(write_rails_log: true, write_context_log: true)
    end

    it 'write_db_log' do
      described_class.set_destinations(write_db_log: true, write_context_log: false)
      expect(described_class.destinations).to eq(write_db_log: true)
    end

    it 'with illegal destination - should be ignored' do
      described_class.set_destinations(write_db_log: true, illegal_destination_should_be_ignored: true)
      expect(described_class.destinations).to eq(write_db_log: true)
    end
  end

  context 'self.logs_folder' do
    it 'should build logs\' folder properly' do
      expect(described_class.logs_folder).to eq('root_directory/log')
    end
  end

  context 'self.log_file_path' do
    it 'should build log_file_path properly with legal filename based on context' do
      expect(described_class.log_file_path(:publish)).to eq('root_directory/log/publish.log')
      expect(described_class.log_file_path('publish context')).to eq('root_directory/log/publish_context.log')
      expect(described_class.log_file_path('@publish $context')).to eq('root_directory/log/publish_context.log')
      expect(described_class.log_file_path('@publish $context123')).to eq('root_directory/log/publish_context123.log')
    end
  end

  context 'self.log' do
    it 'all destinations - should call methods to write to all destinations' do
      params = {context: :publish, severity: :info}
      params_with_defaults = described_class.options.merge(params.reject{|_, v| v.nil?})
      described_class.set_destinations({
                                           write_rails_log: true,
                                           write_context_log: true,
                                           write_db_log: true
                                       })

      expect(described_class).to receive(:write_rails_log).with(params_with_defaults)
      expect(described_class).to receive(:write_context_log).with(params_with_defaults)
      expect(described_class).to receive(:write_db_log).with(params_with_defaults)

      described_class.log(params_with_defaults)
    end

    it 'partial destinations - should call methods to write to part of destinations' do
      params = {context: :publish, severity: :info}
      params_with_defaults = described_class.options.merge(params.reject{|_, v| v.nil?})
      described_class.set_destinations({
                                           write_context_log: true,
                                           write_db_log: true
                                       })

      expect(described_class).to_not receive(:write_rails_log).with(params_with_defaults)
      expect(described_class).to receive(:write_context_log).with(params_with_defaults)
      expect(described_class).to receive(:write_db_log).with(params_with_defaults)

      described_class.log(params_with_defaults)
    end
  end

  context 'self.write_rails_log' do
    it 'expects call the proper Rails.logger method with the proper params' do
      params = {context: :publish, severity: :info}
      params_with_defaults = described_class.options.merge(params.reject{|_, v| v.nil?})


      expect(Rails.logger). to receive(:info).with(params_with_defaults.except(:severity))
      described_class.write_rails_log(params_with_defaults)
    end
  end

  context 'self.write_context_log' do
    it 'expects call the proper Logger method with the proper params' do
      params = {context: :publish, severity: :info, action_id: 123}
      params_with_defaults = described_class.options.merge(params.reject{|_, v| v.nil?})

      expect_any_instance_of(Logger).to receive(:info).with(params_with_defaults.except(:severity, :context))
      described_class.write_context_log(params_with_defaults)
    end
  end

  context 'self.write_db_log' do
    it 'expects call the create method of ::ContextLog with the proper params' do

      params = {context: :publish, severity: :info, action_id: 123}
      params_with_defaults = described_class.options.merge(params.reject{|_, v| v.nil?})

      column_names = ContextLog.columns.map(&:name)
      expected_params = described_class.options.merge(params_with_defaults).select{|k, _| column_names.include?(k)}
      expect(::ContextLog).to receive(:create).with(expected_params)
      described_class.write_db_log(params_with_defaults)
    end
  end

end