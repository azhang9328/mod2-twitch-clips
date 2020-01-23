class FavoriteClipsController < ApplicationController
    before_action :find_favorite_clip, only: [:show, :edit, :update, :destroy]
    before_action :correct_user?, only: [:edit, :update, :destroy]

    def update
        @favorite_clip.update(params.require(:favorite_clip).permit(:title))
        redirect_to controller: 'favorite_clips', action: 'show'
    end

    def favorite 
        clip = Clip.find(params[:id]).as_json
        tempclip = clip.except("id")
        tempclip["clip_id"] = clip['id']
        favorite_clip = FavoriteClip.create(tempclip)
        if !@user.favorite_clips.include?(favorite_clip)
            @user.favorite_clips << favorite_clip
            redirect_to controller: 'pages', action: 'home'
        else 
            redirect_to controller: 'clips', action: 'show'
        end 
    end

    def destroy 
        @favorite_clip.destroy
        redirect_to controller: 'users', action: 'show', id: "#{@user.id}"
    end

    private 

    def correct_user?
        puts "---current user: #{@user.id} link user id: #{params[:user_id]}"
        current_id = @user.id 
        link_id = params[:user_id]
        if current_id.eql?(link_id)
            puts "---current id: #{current_id} link id: #{link_id}"
            redirect_to controller: 'users', action: 'show', id: "#{params[:user_id]}"
        end
    end

	def find_favorite_clip 
		@favorite_clip  = FavoriteClip.find(params[:id])
	end
end