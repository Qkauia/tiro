class ArticlesController < ApplicationController

    # validates ${:attribute}
    def index
    end

    def new
        @article = Article.new
    end

    def create
        article = Article.new(article_params)
        if article.save
            redirect_to "/articles"
        else
        end
    end

    def article_params
        params.require(:article).permit(:title, :content)
    end
end
