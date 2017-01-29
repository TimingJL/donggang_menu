class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.string :imageURL
      t.boolean :vegetarian
      t.text :note
      t.integer :count
      t.integer :rating
      t.integer :score

      t.timestamps
    end
  end
end
