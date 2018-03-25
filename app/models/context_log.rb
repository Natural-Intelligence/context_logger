class ContextLog < ActiveRecord::Base
  def message=(message)
    @message = message[0..20000]
  end
end