class CreateLocalisations < ActiveRecord::Migration[6.1]
  def change
    create_table :localisations do |t|
      t.integer :number
      t.string :street_type
      t.string :street
      t.string :district
      t.string :city
      t.integer :dept
      t.string :region
      t.decimal :logitude
      t.decimal :latitude
      t.integer :radius
      t.integer :time

      t.timestamps
    end
  end
end
