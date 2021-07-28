class CreateClassifiedads < ActiveRecord::Migration[6.1]
  def change
    create_table :classifiedads do |t|
      t.string    :adReference
      t.string  :title
      t.text    :short_description
      t.date    :publicationdate
      t.date    :deletedate
      t.decimal :rewardPro
      t.decimal :rewardProPercent
      t.decimal :rewardInd
      t.decimal :rewardIndPercent

      t.timestamps
    end
  end
end
