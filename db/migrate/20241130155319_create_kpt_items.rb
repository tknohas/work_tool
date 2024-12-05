class CreateKptItems < ActiveRecord::Migration[8.0]
  def change
    create_table :kpt_items do |t|
      t.references :user, null: false, foreign_key: true
      t.text :keep, null: false
      t.text :problem, null: false
      t.text :try, null: false

      t.timestamps
    end
  end
end
