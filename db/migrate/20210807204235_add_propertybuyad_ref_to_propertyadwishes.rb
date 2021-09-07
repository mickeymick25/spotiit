class AddPropertybuyadRefToPropertyadwishes < ActiveRecord::Migration[6.1]
  def change
    add_column :propertyadwishes, :propertytypewish_id, :integer, null: true
    add_column :propertyadwishes, :propertystatewish_id , :integer , null: true
    add_column :propertyadwishes, :propertydetailwish_id , :integer , null: true
    add_column :propertyadwishes, :insidefeaturewish_id , :integer , null: true
    add_column :propertyadwishes, :outsidefeaturewish_id , :integer , null: true
    add_column :propertyadwishes, :sharedfeaturewish_id , :integer , null: true
    add_column :propertyadwishes, :propertylocationwish_id , :integer , null: true
    
    add_foreign_key :propertyadwishes, :propertybuyads, column: :propertytypewish_id
    add_foreign_key :propertyadwishes, :propertybuyads, column: :propertystatewish_id
    add_foreign_key :propertyadwishes, :propertybuyads, column: :propertydetailwish_id
    add_foreign_key :propertyadwishes, :propertybuyads, column: :insidefeaturewish_id
    add_foreign_key :propertyadwishes, :propertybuyads, column: :outsidefeaturewish_id
    add_foreign_key :propertyadwishes, :propertybuyads, column: :sharedfeaturewish_id
    add_foreign_key :propertyadwishes, :propertybuyads, column: :propertylocationwish_id  
  end
end
