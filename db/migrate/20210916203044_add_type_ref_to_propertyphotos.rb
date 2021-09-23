class AddTypeRefToPropertyphotos < ActiveRecord::Migration[6.1]
  def change
    add_reference :propertyphotos, :type, null: true, foreign_key: true
  end
end
