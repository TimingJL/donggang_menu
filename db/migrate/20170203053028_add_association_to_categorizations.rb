class AddAssociationToCategorizations < ActiveRecord::Migration[5.0]
  def change
    add_column :categorizations, :restaurant_id, :integer
    add_column :categorizations, :category_id, :integer
  end
end
