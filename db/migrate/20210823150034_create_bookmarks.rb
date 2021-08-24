class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.string :spot_reference
      t.references :user, null: false, foreign_key: true
      t.text :note
      t.boolean :visited
      t.integer :personal_rating

      t.timestamps
    end
  end
end
