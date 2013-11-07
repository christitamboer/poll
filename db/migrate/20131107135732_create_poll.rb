class CreatePoll < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end
    add_index(:polls, :user_id)
  end
end
