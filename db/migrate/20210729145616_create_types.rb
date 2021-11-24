class CreateTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :types do |t|
      t.string :sector
      t.string :catetory
      t.string :typeName
      t.string :typekey

      t.timestamps
    end
  end
end
