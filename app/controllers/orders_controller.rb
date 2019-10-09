class OrdersController < ApplicationController
    def change_status
        @order = Order.find_by(id: params[:id])
        respond_to do |format|
            if @order.status == "W"
                @order.status = "A"
                @order.save
                flash.now[:success] = "Order Status Updated"
                format.js
            elsif @order.status == "A"
                @order.status = "D"
                @order.save
                flash.now[:success] = "Order Delivered Succesfully"
                format.js { render js:"$('#process-row-"+@order.id.to_s+"').remove();$('#process-order-status-"+@order.id.to_s+"-show').html('D');" }
            elsif @order.status == "D"
                format.js { render js:"$('#process-row-"+@order.id.to_s+"').remove();$('#process-order-status-"+@order.id.to_s+"-show').html('D');" }
            end
        end
    end
end
