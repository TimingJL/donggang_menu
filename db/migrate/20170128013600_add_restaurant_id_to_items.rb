class AddRestaurantIdToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :restaurant_id, :integer
  end
end
