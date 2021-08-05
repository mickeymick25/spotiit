class AddStatusToClassifiedads < ActiveRecord::Migration[6.1]
 
  def up
    execute <<-SQL
      CREATE TYPE ads_status AS ENUM ('draft','to_validate','validated','published','failed','success','not_set');
    SQL
    add_column :classifiedads, :adstatus,  :ads_status
  end

  def down
    remove_column :classifiedads, :adstatus
    execute <<-SQL
      DROP TYPE ads_status;
    SQL
  end
end
