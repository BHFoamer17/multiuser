class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name
      t.string :phone

      t.timestamps null: false
    end
  end
end
