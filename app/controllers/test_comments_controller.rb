class TestCommentsController < ApplicationController

  def new
    @comment = TestComment.new
  end

  def create
    @comment = TestComment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      render :json => {
        :name => @comment.user.name,
        :comment => @comment.comment
      }.to_json
    else
      redirect_to @comment.test_objective.test
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
      params.require(:test_comment).permit(:comment, :user_id, :test_objective_id)
    end
end
