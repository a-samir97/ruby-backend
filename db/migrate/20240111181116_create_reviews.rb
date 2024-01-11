class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer :stars
      t.text :review
      t.string :user
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
