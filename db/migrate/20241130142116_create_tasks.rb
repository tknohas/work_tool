class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.datetime :completed_at
      t.string :priority # 一旦null許可

      t.timestamps
    end
  end
end
