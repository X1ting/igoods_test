class UsersController < ApplicationController
  before_filter :authenticate_user!

  def articles
    @articles = current_user.articles.paginate(:page => params[:page]).order(created_at: :desc)
    render 'articles/index'
  end
end
