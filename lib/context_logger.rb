require 'context_logger/engine'

module ContextLogger

  SEVERITY_TYPES = [:info, :warn, :error, :debug, :fatal, #:unknown
  ]

  DEFAULTS = {
      context: :context_log,
      # action_id: nil,
      # server_name: nil,
      # method: nil,
      # params: nil,
      # message: 'Empty message',
      # stack_trace: nil
  }

  ALL_DESTINATIONS = {
      write_rails_log: true,
      write_context_log: true,
      write_db_log: true
  }

  @options = DEFAULTS.clone

  # build dynamically log methods for each of the SEVERITY_TYPES
  SEVERITY_TYPES.each do |severity_type|
    define_singleton_method severity_type do |message, method, params, stack_trace=nil, action_id=nil, context=nil ,server=nil, object_id=nil|
      self.log({severity: severity_type, context: context, server: server, action_id: action_id, method: method, params: params, message: message, stack_trace: stack_trace, object_id: object_id})
    end
  end

  # hash (caching) of loggers by context
  @context_loggers = {}

  @destinations = {}

  def self.setup(options)
    @options = (@options || {}).merge(options)
  end

  def self.options
    return @options
  end

  def self.set_destinations(_destinations)
    if _destinations == :all
      @destinations = ALL_DESTINATIONS.clone
      return
    end

    @destinations = _destinations.select{|k, v| ALL_DESTINATIONS[k] and v}
  end

  def self.destinations
    return @destinations
  end

  private

  def self.logs_folder
    # TODO: set the path from config
    @logs_folder ||= "#{Rails.root}/log"
  end

  def self.log_file_path(current_context)
    file_name = current_context.to_s.downcase.gsub(/ /, '_').gsub(/[^0-9a-z_]/, '')
    return "#{logs_folder}/#{file_name}.log"
  end

  def self.log(params)
    params_with_defaults = options.merge(params.reject{|_, v| v.nil?})

    destinations.each do |log_destination, _|
      self.send(log_destination, params_with_defaults)
    end
  end

  def self.logger_of_context(current_context)
    @context_loggers[current_context] ||= ::Logger.new(log_file_path(current_context))
  end

  def self.write_rails_log(params_with_defaults)
    Rails.logger.send params_with_defaults[:severity].to_sym, params_with_defaults.except(:severity)
  end

  def self.write_context_log(params_with_defaults)
    logger_instance = logger_of_context(params_with_defaults[:context].to_sym)
    logger_instance.send params_with_defaults[:severity].to_sym, params_with_defaults.except(:context, :severity)
  end

  def self.write_db_log(params_with_defaults)
    ::ContextLog.create(params_with_defaults.select{|k, _| db_log_columns[k]})
  end

  def self.db_log_columns
    return @db_log_columns if @db_log_columns
    @db_log_columns = {}
    if ::ContextLog.respond_to?(:columns)
      ::ContextLog.columns.each{|column| @db_log_columns[column.name.to_sym] = true}
    elsif ::ContextLog.respond_to?(:fields)
      ::ContextLog.fields.keys.each{|column| @db_log_columns[column.to_sym] = true}
    end
    return @db_log_columns
  end

end