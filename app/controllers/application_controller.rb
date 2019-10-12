class ApplicationController < ActionController::Base
    include SessionsHelper
    include ApplicationHelper
    include UsersHelper
    include PusherHelper
    
    before_action :prevent_caching

    private

    def prevent_caching
        response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
        response.headers["Pragma"] = "no-cache"
        response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end
end
