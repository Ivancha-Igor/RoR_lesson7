class CommentsController < ApplicationController
  before_action :authenticate, only: [:create, :update, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html { redirect_to post_path(@post), notice: 'Ваш комментарий успешно сохранен' }
        format.js {}
      end
    end
  end


  def update
  end

  def destroy
    @comment = Comment.find(params[:id])
    if Time.now - @comment.created_at <= 3600
      @comment.delete
    end
    redirect_to root_path
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
  def comment_user
    redirect_to :back unless @comment.user == current_user
  end

end
