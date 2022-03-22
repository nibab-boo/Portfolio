class AddRepoLinkToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :repo_link, :string
  end
end
