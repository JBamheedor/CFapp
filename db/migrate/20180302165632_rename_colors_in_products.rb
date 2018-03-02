class RenameColorsInProducts < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :color, :color
  end
end
