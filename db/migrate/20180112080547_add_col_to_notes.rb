class AddColToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :description, :text
  end
end
