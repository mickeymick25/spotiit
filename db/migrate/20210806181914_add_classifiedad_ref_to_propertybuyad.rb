class AddClassifiedadRefToPropertybuyad < ActiveRecord::Migration[6.1]
  def change
    add_reference :propertybuyads, :classifiedad, null: false, foreign_key: true
  end
end
