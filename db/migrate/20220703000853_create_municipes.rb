class CreateMunicipes < ActiveRecord::Migration[7.0]
  def change
    create_table :municipes, id: :uuid do |t|
      t.string :full_name, null: false
      t.string :document_cpf, null: false
      t.string :document_cns, null: false
      t.string :email, null: false
      t.date :birthdate, null: false
      t.string :ddi, default: '+55', null: false
      t.string :ddd, null: false
      t.string :phone, null: false
      t.string :status, default: 'active', null: false

      t.timestamps
    end
    add_index :municipes, :document_cpf, unique: true
    add_index :municipes, :document_cns, unique: true
    add_index :municipes, :email, unique: true
    add_index :municipes, :birthdate
    add_index :municipes, :ddi
    add_index :municipes, :phone
    add_index :municipes, :status
  end
end
