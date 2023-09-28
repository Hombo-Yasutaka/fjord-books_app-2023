class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :owner
      t.references :imageable, polymorphic: true

      t.timestamps
    end
  end
end
