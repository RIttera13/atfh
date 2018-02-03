class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :organization_name
      t.string :organization_address
      t.string :organization_contact_name
      t.string :organization_contact_email
      t.string :organization_contact_phone
      t.string :organization_notes
      t.boolean :organization_active, default: true

      t.timestamps
    end
  end
end
