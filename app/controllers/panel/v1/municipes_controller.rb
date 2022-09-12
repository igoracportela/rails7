module Panel
  module V1
    class MunicipesController < PanelController
      before_action :set_items, :set_item

      def index; end

      def create
        @item = Municipe.create(_params)
      rescue StandardError => e
        @error = e.message
      end

      def update
        @item.update(_params)
      rescue StandardError => e
        @item.errors.add(:id, e.message)
      end

      private

      def _params
        params
          .require(:municipe)
          .permit(
            :full_name,
            :birthdate,
            :document_cpf,
            :document_cns,
            :ddi,
            :ddd,
            :phone,
            :email,
            :picture,
            :status
          )
      end

      def set_items
        if params[:query].blank?
          @items = Municipe.page(current_page)
        else
          @items = Municipe.search(params[:query].to_s, hitsPerPage: current_per)
        end
      end

      def set_item
        if params[:id].blank?
          @item = Municipe.new
        else
          @item = Municipe.find(params[:id])
        end
      end
    end
  end
end
