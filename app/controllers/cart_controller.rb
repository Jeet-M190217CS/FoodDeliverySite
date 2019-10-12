class CartController < ApplicationController
    def add
        item = Item.find_by(id: params[:id])
        session[:cart] ||= {}

        if session[:cart].length != 0

            if session[:restaurant_id] == item.restaurant_id

                if session[:cart].has_key?(params[:id])
                    session[:cart][params[:id]] += 1
                else
                    session[:cart][params[:id]] = 1
                end

                flash[:success] = "Item added successfully."
                if params[:show] == "MyCart"
                    redirect_to '/dashboard/'+current_user.id.to_s+'?show=MyCart'
                else
                    redirect_to '/dashboard/'+current_user.id.to_s+'?res_items='+item.restaurant_id.to_s
                end
            else
                flash[:danger] = "Can't add item from different restaurant"
                redirect_to '/dashboard/'+current_user.id.to_s+'?res_items='+item.restaurant_id.to_s
            end
        else
            session[:restaurant_id] = item.restaurant_id
            session[:cart][params[:id]] = 1
            flash[:success] = "Item added successfully."
            redirect_to '/dashboard/'+current_user.id.to_s+'?res_items='+item.restaurant_id.to_s
        end
    end

    def remove
        if session[:cart]
            session[:cart][params[:id]] -= 1;

            if session[:cart][params[:id]] == 0
                session[:cart].delete(params[:id])
            end
            flash[:success] = "Item removed successfully."
        end

        if session[:cart].length == 0
            session.delete[:cart]
            session.delete[:restaurant_id]
        end

        redirect_to '/dashboard/'+current_user.id.to_s+'?show=MyCart'
    end

    def clear
        session.delete(:cart)
        session.delete(:restaurant_id)
        flash[:success] = "Cart is cleared."
        redirect_to '/dashboard/'+current_user.id.to_s+'?show=MyCart'
    end

    def order
        if !session[:cart]
           
            @user=User.find_by(id: current_user.id)
            UserMailer.order_confirmation(@user).deliver_now
            flash[:danger] = "Add item to cart !!!"
            redirect_to '/dashboard/'+current_user.id.to_s+'?show=MyCart'
            
            
            return
        end

        user_id = current_user.id
        restaurant_id = session[:restaurant_id]
        session[:cart].delete(:restaurant_id)
        order = Order.create(user_id: user_id, restaurant_id: restaurant_id, status: "W")

        total = 0
        session[:cart].each do |key, value|
            order.ordered_items.push(OrderedItem.create(order_id: order.id, item_id: key, quantity: value))
            total += value
        end

        order.update(total: total)
        order.save

        flash[:success] = "Orderd Placed Successfully!!!\nOrder id:"+order.id.to_s
        @user=User.find_by(id: current_user.id)
       
        UserMailer.order_confirmation(@user).deliver_now
        session.delete(:cart)
        redirect_to '/dashboard/'+current_user.id.to_s+'?show=MyCart' 
    end
end
