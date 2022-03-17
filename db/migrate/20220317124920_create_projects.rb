class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :position
      t.text :colors, array: true, default: []
      t.text :fonts, array: true, default: []
      t.text :experience

      t.timestamps
    end
  end
end
