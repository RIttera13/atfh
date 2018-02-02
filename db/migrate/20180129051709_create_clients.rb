class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :client_name
      t.string :client_address
      t.string :client_contact_name
      t.string :client_contact_email
      t.string :client_contact_phone
      t.string :client_notes

      t.timestamps
    end
  end
end
