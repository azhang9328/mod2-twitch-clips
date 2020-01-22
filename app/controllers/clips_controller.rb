class ClipsController < ApplicationController
    def show 
        @clip = Clip.find(params[:id])
    end
end