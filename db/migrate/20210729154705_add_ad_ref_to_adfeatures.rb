class AddAdRefToAdfeatures < ActiveRecord::Migration[6.1]
  def change
    add_reference :adfeatures, :classifiedad, null: false, foreign_key: true
  end
end
