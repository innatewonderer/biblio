class AddColumnsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :published, :date
    add_column :books, :link, :string

    remove_column :books, :date, :datetime
  end
end
