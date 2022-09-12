class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses, id: :uuid do |t|
      t.references :ownereable, null: false, type: :uuid, polymorphic: true, index: true
      t.string :zip_code, null: false
      t.string :street_name, null: false
      t.string :complement
      t.string :neighborhood, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :ibge_code

      t.timestamps
    end
    add_index :addresses, :zip_code
    add_index :addresses, :street_name
    add_index :addresses, :neighborhood
    add_index :addresses, :state
    add_index :addresses, :ibge_code
  end
end
