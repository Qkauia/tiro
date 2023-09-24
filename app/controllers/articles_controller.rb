class ArticlesController < ApplicationController
    
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
            flash[:notice] = "新增失敗"
            render :new
        end
    end

    def show
        @article = Article.find(params[:id])
    end
    
    def edit
        @article = Article.find(params[:id])
    end

    def update

    end
    
    private

    def article_params
        params.require(:article).permit(:title, :content)
    end

    
end
