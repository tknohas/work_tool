class CreateKptItems < ActiveRecord::Migration[8.0]
  def change
    create_table :kpt_items do |t|
      t.references :daily_report, null: false, foreign_key: true, index: { unique: true }
      t.text :content, null: false

      t.timestamps
    end
  end
end
