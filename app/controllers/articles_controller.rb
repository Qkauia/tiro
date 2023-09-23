class ArticlesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    # validates ${:attribute}
    def index
        @articles = Article.all.order(id: :desc)
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to "/articles", notice: "文章新增成功"
        else
            render :new
        end
    end

    def show
        @article = Article.find(params[:id])
        render html: @article.title
    end

    def article_params
        params.require(:article).permit(:title, :content)
    end

    
end
