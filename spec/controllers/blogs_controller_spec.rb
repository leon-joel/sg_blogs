require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  describe 'GET #index' do
    it "get index で indexがrenderされること" do
      get :index
      expect(response).to render_template :index
    end

    it "@blogsに全てのBlogが入っていること" do
      blog = create(:blog)    # FactoryGirlで :blog をDBに登録
      get :index              # getリクエスト送信

      # コントローラーから @blogs を返していて、blog を含んでいるはず ★includeを使う以外のテスト方法が分からない！
      expect(assigns(:blogs)).to include(blog)  # ※eq だと、ActiveRecord::Relation と Blogモデルの比較でエラーになる
    end
  end

  describe 'POST #create' do
    it "新規作成後に@blogのshowに遷移すること" do
      post :create, blog: { title: 'aaa' }
      @blog = assigns(:blog)
      expect(response).to redirect_to blog_path(@blog)

      expect(@blog.title).to eq "aaa"
    end
  end
end
