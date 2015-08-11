class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :company_name
      t.string :phone

      t.timestamps null: false
    end
  end
end
