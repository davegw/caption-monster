class AddRegisteredAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :registered_at, :datetime
    add_column :users, :status_id, :integer
  end
end
