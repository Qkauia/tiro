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
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to article_path, notice: "修改成功！！"
        else
            flash[:notice] = "修改失敗"
            render :edit
        end
    end
    
    private

    def article_params
        params.require(:article).permit(:title, :content)
    end

    
end
