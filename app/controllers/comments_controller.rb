class CommentsController < ApplicationController
  before_action :set_comment, only: [:approve, :destroy]

  # POST /blogs/:blog_id/entries/:entry_id/comments
  def create
    @comment = Comment.new(comment_params)
    @entry = Entry.find(params[:entry_id])

    if @entry.blog_id.to_s != params[:blog_id]
      return redirect_to (request.referer || blog_path(params[:blog_id]))
    end

    msg = @comment.save ? 'Comment was successfully created.' : 'Comment was failed to create.'
    redirect_to blog_entry_path(@entry.blog_id, @entry.id), notice: msg
  end

  # DELETE /blogs/:blog_id/entries/:entry_id/comments/:id
  def destroy
    @entry = Entry.find(params[:entry_id])
    if @comment.entry_id != @entry.id || @entry.blog_id.to_s != params[:blog_id]
      return redirect_to (request.referer || blog_path(params[:blog_id])), notice: "不整合"
    end

    @comment.destroy
    redirect_to blog_entry_path(@entry.blog_id, @entry.id), notice: 'Comment was successfully destroyed.'
  end

  # PATCH /blogs/:blog_id/entries/:entry_id/comments/:id
  def approve

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:entry_id, :body)
    end
end
