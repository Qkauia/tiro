class ArticlesController < ApplicationController

    before_action :set_article, only:[:show]
    before_action :set_user_article, only:[:edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show, :unlock]

    def index
        keyword = params[:keyword]
        # @articles = Article.search(keyword).order(id: :desc)

        @q = Article.ransack(title_or_content_or_subtitle_cont:(keyword))
        @articles = @q.result(distinct: true).page(params[:page]).per(4)

    end


    def new
        authorize :article
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
        @comments = @article.comments
    end
    
    def edit
    end

    def update
        authorize(@article)
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

    def unlock
        result = Article.exists?(id: params[:id], password: params[:article][:password])

        if result
            if session[:article].present?
                session[:article] << params[:id] unless session[:article].include?(params[:id])
                else
                    session[:article] = [params[:id]]
                end
                redirect_to article_path(id: params[:id])
        else
            redirect_back_or_to root_path, notice: "密碼錯誤"
        end
    end
    
    private

    def article_params
        params.require(:article).permit(:title, :content, :subtitle, :password, :category)
        
    end

    def set_article
        @article = Article.find(params[:id])
        if @article.password.present?
        redirect_to root_path if not can_read?(params[:id])
        end
    end

    def can_read?(id)
        session[:article]&.include?(id)
    end



    def set_user_article
        @article = current_user.articles.find(params[:id])
    end
    
end
