class ArticlesController < ApplicationController

    before_action :set_article, only:[:show]
    before_action :set_user_article, only:[:edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]

    def index
        @articles = Article.includes(:user).order(id: :desc)
    end

    def new
        @article = Article.new
    end

    def create
        @article = current_user.articles.new(article_params)

        if @article.save
            redirect_to "/articles", notice: "文章新增成功"
        else
            flash[:notice] = "新增失敗"
            render :new
        end
    end

    def show
        @comment = Comment.new
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
        redirect_to articles_path, notice: "刪除成功！！"
    end
    
    private

    def article_params
        params.require(:article)
        .permit(:title, :content, :subtitle)
        # .merge(user: current_user)
    end

    def set_article
        @article = Article.find(params[:id])
    end

    def set_user_article
        @article = current_user.articles.find(params[:id])
    end
    
end
