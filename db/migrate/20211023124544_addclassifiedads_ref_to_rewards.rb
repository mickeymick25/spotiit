class AddclassifiedadsRefToRewards < ActiveRecord::Migration[6.1]
  def change
    add_reference :rewards, :classifiedad, null: false, foreign_key: true
  end
end
