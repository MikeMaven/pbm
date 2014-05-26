module Api
  module V1
    class LocationMachineXrefsController < InheritedResources::Base
      respond_to :json
      has_scope :region, :limit

      def index
        lmxes = apply_scopes(LocationMachineXref).order('id desc')
        return_response(lmxes, 'location_machine_xrefs')
      end

      def create
        location = params[:location_id]
        machine = params[:machine_id]
        condition = params[:condition]

        lmx = LocationMachineXref.find_by_location_id_and_machine_id(location, machine)
        if (!lmx)
          lmx = LocationMachineXref.create(:location_id => location, :machine_id => machine)
        end

        if (condition)
          lmx.update_condition(condition, {:remote_ip => request.remote_ip})
        end

        return_response(lmx, 'location_machine')
      end

      def update
        lmx = LocationMachineXref.find(params[:id])
        lmx.update_condition(params[:condition], {:remote_ip => request.remote_ip})

        return_response(lmx, 'location_machine')

        rescue ActiveRecord::RecordNotFound
          return_response('Failed to find machine', 'errors')
      end

      def destroy
        lmx = LocationMachineXref.find(params[:id])
        lmx.destroy

        return_response('Successfully deleted lmx #' + lmx.id.to_s, 'msg')

        rescue ActiveRecord::RecordNotFound
          return_response('Failed to find machine', 'errors')
      end

    end
  end
end