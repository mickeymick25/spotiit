class AddPropertystateToPropertyads < ActiveRecord::Migration[6.1]

  def up
    execute <<-SQL
      CREATE TYPE property_state AS ENUM ('recent','old','lifeannuity','offplan','not_set');
    SQL
    add_column :propertyads, :propertystate, :property_state
  end
  def down
    remove_column :propertyads, :propertystate
    execute <<-SQL
      DROP TYPE property_state;
    SQL
  end
end
