module API
  module V1
    module Resources
      class ContextLoggersController < ::ActionController::Base
        def index
            if params[:action_id].nil?
              render json: {error: 'Missing mandatory parameter action_id'}, :status => 400, layout: false
              return
            end
            #TODO: add pagination
            render json: ::ContextLog.where(action_id: params[:action_id]).all, layout: false, :root => false
        end
      end
    end
  end
end