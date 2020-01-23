class StreamersController < ApplicationController
    def show 
        @streamer = Streamer.find(params[:id])
    end
end