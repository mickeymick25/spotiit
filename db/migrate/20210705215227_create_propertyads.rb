class CreatePropertyads < ActiveRecord::Migration[6.1]
  def change
    create_table :propertyads do |t|
      t.integer :netprice
      t.decimal :livingarea
      t.integer :landarea
      t.integer :rooms
      t.integer :bedrooms
      t.integer :floor
      t.integer :buildingyear
      t.boolean :cmtyheating
      t.string  :energydiagnostic
      t.string  :carbon
      t.date    :availability
      t.text    :description

      t.timestamps
    end
  end
end
