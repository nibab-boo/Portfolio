class RemoveLanguaguesFromProjects < ActiveRecord::Migration[6.1]
  def change
    remove_column :projects, :languagues, :string
  end
end
