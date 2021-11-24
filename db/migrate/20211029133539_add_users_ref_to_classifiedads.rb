class AddUsersRefToClassifiedads < ActiveRecord::Migration[6.1]
  def change
    add_reference :classifiedads, :user, null: true, foreign_key: true
  end
end