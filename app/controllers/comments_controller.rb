class CommentsController < ApplicationController
  before_action :set_comment, only: [:approve, :destroy]

  # POST /blogs/:blog_id/entries/:entry_id/comments
  def create
    @comment = Comment.new(comment_params)

    # INNER JOIN
    # @blog = Blog.joins(:entries)
    #             .where(entries: { id: params[:entry_id] })
    #             .select("blogs.*, entries.title AS entry_title, entries.body")
    #             .first
    # p @blog
    # p @blog.attributes

    # LEFT OUTER JOIN
    @blog = Blog.includes(:entries).where(entries: { id: params[:entry_id] }).first
    # p @blog

    if @blog.id.to_s != params[:blog_id]
      return redirect_to (request.referer || blog_path(params[:blog_id])), notice: '不整合'
    end

    msg = @comment.save ? 'Comment was successfully created.' : 'Comment was failed to create.'

    # 保存後にUserMailerを使用してwelcomeメールを送信
    CommentMailer.new_comment_email(@comment, @blog).deliver_later
    # ※save前に実行すると、「Unable to create a Global ID for Comment without a model id.」というエラーが。

    redirect_to blog_entry_path(@blog.id, @blog.entries[0].id), notice: msg
  end

  # DELETE /blogs/:blog_id/entries/:entry_id/comments/:id
  def destroy
    @entry = Entry.find(params[:entry_id])
    if @comment.entry_id != @entry.id || @entry.blog_id.to_s != params[:blog_id]
      return redirect_to (request.referer || blog_path(params[:blog_id])), notice: "不整合"
    end

    msg = @comment.destroy ? 'Comment was successfully destroyed.' : 'Failed to delete comment.'
    redirect_to blog_entry_path(@entry.blog_id, @entry.id), notice: msg
  end

  # PATCH /blogs/:blog_id/entries/:entry_id/comments/:id
  def approve
    @entry = Entry.find(params[:entry_id])
    if @comment.entry_id != @entry.id || @entry.blog_id.to_s != params[:blog_id]
      return redirect_to (request.referer || blog_path(params[:blog_id])), notice: "不整合"
    end

    msg = @comment.update_attribute(:approved, true) ? 'コメントは承認されました ∑d=(´∀`*)ｸﾞｯ' : '承認エラー'
    redirect_to blog_entry_path(@entry.blog_id, @entry.id), notice: msg
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
