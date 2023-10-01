class AlbumsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def index
        @albums = Album.order(id: :desc)
    end

    def new
        @album = Album.new
    end
    
    def create
        @album = current_user.albums.new(album_params)
        if @album.save
            redirect_to albums_path(@album), notice: "相簿新增成功"
        else
            flash[:notice] = "相簿新增失敗"
            render :new
        end
    end

    def show
    end

    private

    def album_params
        params.require(:album).permit(:name, :description, :password, :online)
    end
end
