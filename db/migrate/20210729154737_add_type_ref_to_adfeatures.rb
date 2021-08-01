class AddTypeRefToAdfeatures < ActiveRecord::Migration[6.1]
  def change
    add_reference :adfeatures, :type, null: false, foreign_key: true
  end
end
