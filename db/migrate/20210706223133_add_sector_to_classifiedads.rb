class AddSectorToClassifiedads < ActiveRecord::Migration[6.1]
    
    def up
      execute <<-SQL
        CREATE TYPE sector_type AS ENUM ('Immobilier','Emploi','Auto/moto','Non défini');
      SQL
      add_column :classifiedads, :sector, :sector_type
    end
    def down
      remove_column :classifiedads, :sector
      execute <<-SQL
        DROP TYPE sector_type;
      SQL
    end
  end