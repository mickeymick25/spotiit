class CreateAnnouncerwishes < ActiveRecord::Migration[6.1]
  def change
    create_table :announcerwishes do |t|
      t.integer :wishlevel
      t.string :comment

      t.timestamps
    end
  end
end
