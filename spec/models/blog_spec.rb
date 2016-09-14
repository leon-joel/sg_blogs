require 'rails_helper'

RSpec.describe Blog, type: :model do

  it "titleがあれば有効な状態であること" do
    blog = Blog.new(title: "aaa")
    # expect(blog.valid?).to be_truthy
    expect(blog).to be_valid
    expect(blog.title).to eq "aaa"
  end

  it "titleがなければ無効な状態であること" do
    blog = Blog.new
    # expect(blog.valid?).to be_falsey
    expect(blog).not_to be_valid
    expect(blog.title).to be_blank
  end

  # EDR(EveryDay Rails) p.1335
  it "有効なFactoryを持つこと" do
    expect(FactoryGirl.build(:blog)).to be_valid
  end

  it "titleがあれば有効な状態であること [FactoryGirls版]" do
    blog = FactoryGirl.build(:blog)
    expect(blog.title).to eq "aaa"
    expect(blog).to be_valid
    expect(blog.errors[:title]).to be_blank
  end

  it "titleがなければ無効な状態であること [FactoryGirls版]" do
    blog = FactoryGirl.build(:blog, title: "")
    expect(blog).not_to be_valid
    expect(blog.errors[:title]).to include ("can't be blank")
  end

end
