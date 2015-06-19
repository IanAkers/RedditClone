class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      
      t.timestamps
    end

    add_index :subs, :user_id
  end
end
