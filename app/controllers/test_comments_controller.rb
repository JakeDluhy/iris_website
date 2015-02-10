class TestCommentsController < ApplicationController
  before_action :admin_user, only: [:new, :create, :edit, :update]

  def new
    @comment = TestComment.new
  end

  def create
    @comment = TestComment.new(comment_params)
    if @comment.save
      flash[:success] = "#{@comment.name} comment created"
      redirect_to @comment
    else
      render 'new'
    end
  end

  def edit
    @comment = TestComment.find(params[:id])
  end

  def update
    @comment = TestComment.find(params[:id])
    if @comment.update_attributes(team_params)
      flash[:success] = "TestComment updated"
      redirect_to @comment
    else
      render 'edit'
    end
  end

  def destroy
    TestComment.find(params[:id]).destroy
    redirect_to comments_url
  end

  private

    def comment_params
      params.require(:comment).permit(:comment, :user_id)
    end
end
