module Api
  module V1
    class PackagesController < ActionController::API
      def index
        packages = Package.all
        render status: :ok, json: packages
      end
    end
  end
end
