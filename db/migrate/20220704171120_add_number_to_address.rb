class AddNumberToAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :number, :string
  end
end
