class ChangeClassifiedads < ActiveRecord::Migration[6.1]
  
  def change
    
    change_table :classifiedads do |t|
      t.boolean :fixedreward
    end
  end
end
