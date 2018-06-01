class AddColorFieldsToCountdowns < ActiveRecord::Migration[5.1]
  def change
    add_column :countdowns, :title_color, :string
    add_column :countdowns, :labels_color, :string
    add_column :countdowns, :clock_background_color, :string
    add_column :countdowns, :time_color, :string
  end
end
