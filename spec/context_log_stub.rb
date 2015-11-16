class ContextLog
  def self.columns
    [
        OpenStruct.new(name: :context),
        OpenStruct.new(name: :severity),
        OpenStruct.new(name: :action_id),
        OpenStruct.new(name: :message)
    ]
  end
end
