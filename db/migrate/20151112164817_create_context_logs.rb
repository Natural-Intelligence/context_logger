class CreateContextLogs < ActiveRecord::Migration
  def change
# self.log({severity: severity_type, context: context, server: server, action_id: action_id, method: method, params: params, message: message, stack_trace: stack_trace})

  create_table :context_logs do |t|
      t.string    :context
      t.string    :severity
      t.string    :server
      t.string    :action_id
      t.string    :method
      t.text    :params
      t.text    :message
      t.text    :stack_trace

      t.column :created_at, :datetime
    end
  end
end
