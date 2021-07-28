class AddPropertytypeToPropertyads < ActiveRecord::Migration[6.1]
 
  def up
    execute <<-SQL
      CREATE TYPE property_type AS ENUM ('apartment','house','ground','parking_Box','loft_Workshop','castle','mansion','building','gite','chalet_mobil_home','Barge','commercial_premises','premises','commercial_property','activity_premises','various','not_set');
    SQL
    add_column :propertyads, :propertytype, :property_type
  end
  def down
    remove_column :propertyads, :propertytype
    execute <<-SQL
      DROP TYPE property_type;
    SQL
  end
end
