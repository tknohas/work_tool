class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.datetime :start_at
      t.datetime :stopped_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
