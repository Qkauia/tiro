class Api::V1::ArticlesController < ApplicationController
    before_action :authenticate_user!

    def like
        article = Article.find(params[:id])

        if current_user.liked_articles.include?(article)
            current_user.liked_articles.destroy(article)
            render json: {liked: false, id: params[:id]}
        else
            current_user.liked_articles << article
            render json: {liked: true, id: params[:id]}
        end
    end
end
