class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :image
      t.string :description
      t.datetime :date

      t.timestamps
    end
  end
end
