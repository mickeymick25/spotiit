class CreatePropertybuyads < ActiveRecord::Migration[6.1]
  def change
    create_table :propertybuyads do |t|
      t.integer :budget
      t.integer :supply
      t.string  :financing
      t.text    :description

      t.timestamps
    end
  end
end
