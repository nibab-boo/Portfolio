class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :url
      t.text :languages, array: true, default: []

      t.timestamps
    end
  end
end
