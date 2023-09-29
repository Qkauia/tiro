class Api::V1::ArticlesController < ApplicationController
    before_action :authenticate_user!

    def like
        article = Article.find(params[:id])

        render json: { liked: current_user.toggle_like(article) }
    end
end
