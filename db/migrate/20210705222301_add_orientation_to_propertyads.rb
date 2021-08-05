class AddOrientationToPropertyads < ActiveRecord::Migration[6.1]

  def up
    execute <<-SQL
      CREATE TYPE orientation AS ENUM ('North','North_East','East','South_East','South','South_West','West','North_West','Not_set');
    SQL
    add_column :propertyads, :orientation, :orientation
  end

  def down
    remove_column :propertyads, :orientation
    execute <<-SQL
      DROP TYPE orientation;
    SQL
  end
end
