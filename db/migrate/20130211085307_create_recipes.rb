class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.boolean :appetizer
      t.boolean :vegetarian
      t.boolean :chicken
      t.boolean :meat
      t.boolean :dessert

      t.timestamps
    end
  end
end
