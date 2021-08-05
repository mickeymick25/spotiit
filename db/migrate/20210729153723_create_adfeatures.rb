class CreateAdfeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :adfeatures do |t|
      t.string :comment

      t.timestamps
    end
  end
end