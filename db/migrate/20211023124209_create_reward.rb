class CreateReward < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.decimal :amount
      t.decimal :percent
      t.boolean :type
      

      t.timestamps
    end
  end
end
