class ItemsController < ApplicationController
    before_action :logged_in_user
    before_action :only_user

    def new 
        @item=Item.new
    end

    def create
        @rest=Restaurant.find(params[:restaurant_id])
      
        @item = Item.new(item_params)
        @rest.items.push(@item)
        if @item.save
         flash[:success] = "Items added sucessfully"
         redirect_to '/dashboard/'+current_user.id.to_s+'?show=additem'
         return
        end
        render '/dashboard/'+current_user.id.to_s+'?show=additem'
    end

    def edit
        @item =  Item.find(params[:id])
        @modify_item_path = '/restaurants/'+params[:restaurant_id]+'/items/'+params[:id]
    end

    def update
        @item =  Item.find(params[:id])
        if @item.update(item_params)
         flash[:success] = "Items is  modified"
         redirect_to '/dashboard/'+current_user.id.to_s
        else
         flash[:danger] = "Items is not modified"
         render 'edit'
        end
    end

    def destroy
        @item = Item.find(params[:id])
        @item.destroy
        flash[:success] = "item was removed"
        redirect_to '/dashboard/'+current_user.id.to_s
    end

    

    private
    def item_params
        params.require(:item).permit(:name, :description, :price, :image, :item_type)
    end

    def only_user
        unless current_user.role == "R"
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
