class ContextLog < ActiveRecord::Base

  before_save :trim_message

  def trim_message
    unless self[:message].nil?
      self[:message] = self[:message][0..20000]
    end
  end
end