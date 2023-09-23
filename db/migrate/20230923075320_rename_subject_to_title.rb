class RenameSubjectToTitle < ActiveRecord::Migration[7.0]
  def change
    rename_column :articles, :subject, :title
  end
end
