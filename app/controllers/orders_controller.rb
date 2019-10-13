class OrdersController < ApplicationController
    before_action :logged_in_user
    before_action :only_user

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
                format.js { render js:"$('#process-row-"+@order.id.to_s+"').remove();$('#process-order-status-"+@order.id.to_s+"-show').html('Delivered');" }
            elsif @order.status == "D"
                format.js { render js:"$('#process-row-"+@order.id.to_s+"').remove();$('#process-order-status-"+@order.id.to_s+"-show').html('Delivered');" }
            end
            get_channels_client.trigger('status','change-status',"Status Changed !!!\n"+"Order id:"+@order.id.to_s+"\nOrder Status:"+get_status(@order.status))
        end
    end

    private 
    def only_user
        unless current_user.role == "A"
            log_out
            flash[:danger]  = "Invalid Action"
            redirect_to root_url
        end
    end

    def logged_in_user
        unless user_logged_in?
            flash[:danger]  = "Please log in."
            redirect_to login_url
        end
    end

end
