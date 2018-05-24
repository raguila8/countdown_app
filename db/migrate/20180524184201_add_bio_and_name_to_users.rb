class AddBioAndNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bio, :text
    add_column :users, :name, :string
    add_column :users, :profile_image, :string
  end
end
