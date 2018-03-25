class ContextLog < ActiveRecord::Base

  before_save :trim_message

  def trim_message
    self.attributes[:message] = self.attributes[:message][0..20000]
  end
end