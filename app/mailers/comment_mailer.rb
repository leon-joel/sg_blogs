class CommentMailer < ApplicationMailer

  def new_comment_email(comment, blog)
    @comment = comment
    @blog = blog
    @entry_url  = "http://#{Rails.application.config.action_mailer.default_url_options[:host]}/blogs/#{blog.id}/entries/#{blog.entries[0].id}"
    mail(to: 'admin@example.com', subject: '新しいコメントが投稿されました')
  end

end
