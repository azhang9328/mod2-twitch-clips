class ClipsController < ApplicationController
    def show 
        @clip = Clip.find(params[:id])
        @embed = @clip.url.gsub(/\A\w+\W{3}\w+\.\w+\.\w+\//, "https://clips.twitch.tv/embed?clip=")
    end
end