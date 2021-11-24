class AddTypeRefToReward < ActiveRecord::Migration[6.1]
  def change
    
    add_column :rewards, :status , :integer , null: true
    
    add_foreign_key :rewards, :types, column: :status
  end
end
