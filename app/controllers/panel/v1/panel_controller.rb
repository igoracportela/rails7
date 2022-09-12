module Panel
  module V1
    class PanelController < ActionController::Base
      before_action :set_menu
      layout('panel')

      private

      def set_menu
        @has_menu_actions = true
      end

      def current_page
        params[:page] || 1
      end

      def current_per
        params[:per] || 25
      end
    end
  end
end