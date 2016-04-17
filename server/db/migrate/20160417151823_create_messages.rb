class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :client_id, null: false, index: true
      t.string :content, null: false
      t.timestamps
    end
  end
end