module Controller
  module StoreRemoteIpConcern
    extend ActiveSupport::Concern

    included do
      before_action :store_remote_ip
    end

    private

    def store_remote_ip
      RequestLocals.store[:remote_ip] = request.remote_ip
    end
  end
end