class CreatePropertyphotos < ActiveRecord::Migration[6.1]
  def change
    create_table :propertyphotos do |t|
      t.string :title
      t.text :comment
      t.text :image_data

      t.timestamps
    end
  end
end
