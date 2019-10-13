module OrdersHelper
    def get_status(status)
        if status=="W"
            "Placed"
        elsif status=="A"
            "In trasit"
        else
            "Delivered"
        end
    end
end
