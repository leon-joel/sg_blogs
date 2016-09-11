require 'rails_helper'

RSpec.feature "Blogs", type: :feature do
  scenario 'Blogの新規作成時にtitleを入力しなかった場合にエラーが表示されること' do
    visit blogs_path
    click_link 'New Blog'
    expect(current_path).to eq new_blog_path

    click_button 'Create Blog'              # POST /blogs
    expect(current_path).to eq blogs_path   # pathは /blogs のまま。中身は new.html (_forms.html) となっている。
    expect(page).to have_content 'Title can\'t be blank'  # @blog.save で発生したエラー内容が表示される
  end

  # 注意！シナリオ名に日本語を使うと、RubyMineでシナリオ指定で実行した時に訳の分からないエラーになる
  #         Run options: include {:full_description=>/Blogs\ Blog\x{82CC}\x{9056}.../}
  #         :
  #         Empty test suite.
  #       ※IntelliJ + Mac なら解決方法があるようだが… http://subcrenated26.rssing.com/chan-13667778/all_p2.html
  #
  scenario 'Blogの新規作成時にtitleを入力した場合はデータが保存され閲覧画面に遷移すること' do
    visit blogs_path
    click_link 'New Blog'
    fill_in 'Title', with: 'title'

    expect {
      click_button 'Create Blog'
    }.to change(Blog, :count).by(1)

    expect(current_path).to eq blog_path(Blog.last)
    # expect(page).to have_current_path(blog_path(Blog.last))

    expect(page).to have_content 'Blog was successfully created.'
  end
end
