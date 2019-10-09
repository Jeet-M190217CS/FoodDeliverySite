class OrdersController < ApplicationController
    def change_status
        @order = Order.find_by(id: params[:id])

        if @order.

        respond_to do |format|
            format.js
        end
    end
end
