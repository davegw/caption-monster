class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.belongs_to :entry
      t.text :message
      t.integer :votes
      t.belongs_to :user

      t.timestamps
    end
  end
end
