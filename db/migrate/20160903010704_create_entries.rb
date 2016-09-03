class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :blog, index: true, foreign_key: true
      t.string :title
      t.string :body

      t.timestamps null: false
    end
  end
end
