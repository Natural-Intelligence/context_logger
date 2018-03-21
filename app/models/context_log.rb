class ContextLog < ActiveRecord::Base
  def message=(message)
    self.attributes[:message] = message[0..20000]
  end
end