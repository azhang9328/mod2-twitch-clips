class FavoriteClipsController < ApplicationController
    before_action :find_favorite_clip, only: [:show, :edit, :update, :destroy]
    before_action :correct_user?, only: [:show, :edit, :update, :destroy]

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
        link_user_id = params[:user_id]
        if !@user.favorite_clips.include?(FavoriteClip.find(params[:id]))
            puts "---incorrect user"
            redirect_to controller: 'users', action: 'show', id: "#{link_user_id}"
        end
    end

	def find_favorite_clip 
		@favorite_clip  = FavoriteClip.find(params[:id])
	end
end