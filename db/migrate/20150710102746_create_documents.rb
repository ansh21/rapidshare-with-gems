class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.attachment :asset
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
