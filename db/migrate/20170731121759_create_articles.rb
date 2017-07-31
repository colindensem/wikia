class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.timestamps

      t.references :user, foreign_key: true
      t.string :title
      t.string :language
      t.string :excerpt
      t.text :body

    end
  end
end
