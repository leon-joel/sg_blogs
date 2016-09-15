require 'rails_helper'

RSpec.describe Entry, type: :model do
  it "title と body があれば有効" do
    # entry = FactoryGirl.build(:entry)
    entry = build(:entry)
    # p entry.blog
    expect(entry).to be_valid
    expect(entry.blog).not_to be_nil
  end

  it "title が空は無効" do
    # entry = FactoryGirl.build(:entry, title: nil)
    entry = build(:entry, title: nil)
    expect(entry).not_to be_valid

    entry = FactoryGirl.build(:entry, body: "")
    expect(entry).not_to be_valid
  end
end
