class RemoveBioAndProfileImageFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :bio, :text
    remove_column :users, :profile_image, :string
  end
end
