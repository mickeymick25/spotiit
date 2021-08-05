class CreateAnnonceurs < ActiveRecord::Migration[6.1]
  def change
    create_table :annonceurs do |t|
      t.integer :sucessed_Ad
      t.integer :failed_Ad

      t.integer :reward_engaged
      t.integer :reward_paid
      t.integer :reward_topay

      t.timestamps
    end
  end
end
