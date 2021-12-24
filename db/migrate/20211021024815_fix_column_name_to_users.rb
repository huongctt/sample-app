class FixColumnNameToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :reset_sent_At, :reset_sent_at
  end
end
