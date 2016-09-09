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
end
