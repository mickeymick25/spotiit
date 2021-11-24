class CreatePropertyadwishes < ActiveRecord::Migration[6.1]
  def change
    create_table :propertyadwishes do |t|
      t.integer :wishlevel
      t.string :comment

      t.timestamps
    end
  end
end
