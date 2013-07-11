class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :priority, default: 0
      t.boolean :done, default: false
      t.references :user

      t.timestamps
    end
  end
end
