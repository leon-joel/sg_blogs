class CommentMailer < ApplicationMailer

  def new_comment_email(comment, blog)
    @comment = comment
    @blog = blog
    @url  = "http://localhost:3000/blogs/#{blog.id}/entries/#{blog.entries[0].id}/comments/#{comment.id}"
    mail(to: 'admin@example.com', subject: '新しいコメントが投稿されました')
  end

end
