class ArticlesController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :check_rules, only: [:edit, :update, :destroy]
  before_action :prepare_tags, only: [:edit, :new, :create, :index, :by_tag]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.published.includes(:user).paginate(:page => params[:page]).order(created_at: :desc)
  end

  def by_tag
    @articles = Article.tagged_with(params[:tag]).paginate(:page => params[:page]).order(created_at: :desc)
    render action: :index
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @comment = Comment.new
    @comments = @article.comments
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = current_user

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def check_rules
      redirect_to action: :index if (@article.user != current_user)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :text, :not_publish, tag_list: [])
    end

    def prepare_tags
      @tags = ActsAsTaggableOn::Tag.all
    end
end
