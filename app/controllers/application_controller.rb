class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    include CableReady::Broadcaster
end
