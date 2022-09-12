module Panel
  module V1
    class MunicipeAddressesController < PanelController
      before_action :set_item

      def index; end

      def create
        @item = Address.create!(_params.merge(ownereable: @municipe))
      rescue StandardError => e
        @error = e.message
      end

      def update
        @item.update(_params)
      rescue StandardError => e
        @item.errors.add(:id, e.message)
      end

      def search_zip_code
        @item.errors.add(:zip_code, :required) if params[:zip_code].blank?
        @item.errors.add(:zip_code, :max_length) if params[:zip_code].to_s.size > 9
        @item.errors.add(:zip_code, :min_length) if params[:zip_code].to_s.size < 8

        _search_zip_code unless @item.errors.present?

        render turbo_stream: turbo_stream.update(:address_form_container, partial: "panel/v1/municipe_addresses/shared/form", locals: { item: @item, item_path: panel_v1_municipe_municipe_addresses_path(@municipe), item_method: :post })
      end

      private

      def _params
        params
          .require(:address)
          .permit(
            :street_name,
            :number,
            :neighborhood,
            :city,
            :state,
            :complement,
            :ibge_code,
            :zip_code
          )
      end

      def set_item
        @municipe = Municipe.find(params[:municipe_id])

        if params[:id].blank?
          @item = Address.new
        else
          @item = Address.find(params[:id])
        end
      end

      def _search_zip_code
        zip_code_object = ZipCodeService.new(params[:zip_code]).fetch
        if zip_code_object
          @item = Address.new(zip_code_object)
        else
          @item.errors.add(:zip_code, :data_not_found)
        end
      end
    end
  end
end
