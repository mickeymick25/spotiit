class AddClassifiedadsRefToPropertyads < ActiveRecord::Migration[6.1]
  def change
    add_reference :propertyads, :classifiedad, null: false, foreign_key: true
  end
end
