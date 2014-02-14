class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :result
      t.belongs_to :user
      t.belongs_to :label

      t.timestamps
    end
  end
end
