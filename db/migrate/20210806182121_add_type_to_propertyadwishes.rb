class AddTypeToPropertyadwishes < ActiveRecord::Migration[6.1]
  def change
    add_reference :propertyadwishes, :type, null: false, foreign_key: true
  end
end
