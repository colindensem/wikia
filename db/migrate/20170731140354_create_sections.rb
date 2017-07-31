class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |t|
      t.timestamps
      t.references :article, foreign_key: true
      t.string :title
      t.text :content

    end
  end
end
