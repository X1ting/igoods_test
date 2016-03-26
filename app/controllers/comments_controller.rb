class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :find_article
  before_action :find_comment, only: [:update, :destroy, :edit]

  def edit
  end

  def create
    comment = Comment.new(comment_params.merge(article: @article, user: current_user))
    if comment.save
      redirect_to article_path(@article)
    end
  end

  def update
    if @comment.can_be_edited?
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to @article, notice: 'Article was successfully updated.' }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    if @comment.can_be_destroyed? && @comment.destroy
      redirect_to article_path(@article)
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_article
    @article = Article.find(params[:article_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
