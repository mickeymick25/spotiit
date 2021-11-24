class AddPropertyadRefToAdfeatures < ActiveRecord::Migration[6.1]
  def change
    add_reference :adfeatures, :propertyad, null: false, foreign_key: true
  end
end
