class RenameToSubject < ActiveRecord::Migration[7.0]
  def change
    rename_column :articles, :title, :subject
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
