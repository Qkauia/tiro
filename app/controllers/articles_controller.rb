class ArticlesController < ApplicationController

    before_action :set_article, only:[:show, :edit, :update, :destroy]
    include UsersHelper

    def index
        @u = current_user
        @articles = Article.order(id: :desc)
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
    end
    
    def edit
    end

    def update
        if @article.update(article_params)
            redirect_to article_path, notice: "修改成功！！"
        else
            flash[:notice] = "修改失敗"
            render :edit
        end
    end

    def destroy
        @article.destroy
        redirect_to article_path, notice: "刪除成功！！"
    end
    
    private

    def article_params
        params.require(:article).permit(:title, :content, :subtitle)
    end

    def set_article
        @article = Article.find(params[:id])
    end
end
