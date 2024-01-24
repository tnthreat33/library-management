class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :ISBN
      t.string :title
      t.string :author
      t.integer :total_copies
      t.integer :available_copies

      t.timestamps
    end
  end
end
