class CreateCountdowns < ActiveRecord::Migration[5.1]
  def change
    create_table :countdowns do |t|
      t.string :name
      t.string :main_image
      t.string :background_image
      t.datetime :date

      t.timestamps
    end
  end
end
