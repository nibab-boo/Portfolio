class AddLanguagesToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :languages, :text , array: true, default: []
  end
end
