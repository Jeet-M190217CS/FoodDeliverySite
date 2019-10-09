module PusherHelper
    require 'pusher'

    def get_channels_client
        channels_client = Pusher::Client.new(
            app_id: '877319',
            key: '033b707bcaba4f7c5f3d',
            secret: '247276e23fcf43f121c4',
            cluster: 'ap2',
            encrypted: true
        )    
    end
end