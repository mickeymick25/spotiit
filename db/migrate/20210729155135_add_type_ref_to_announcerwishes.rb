class AddTypeRefToAnnouncerwishes < ActiveRecord::Migration[6.1]
  def change
    add_reference :announcerwishes, :type, null: false, foreign_key: true
  end
end
