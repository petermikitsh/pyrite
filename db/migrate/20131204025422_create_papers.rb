class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.string :title
      t.string :authors
      t.date :published_on
      t.string :journal
      t.string :volume
      t.string :issue
      t.string :pages
      t.string :url
      t.integer :project_id

      t.timestamps
    end
  end
end
