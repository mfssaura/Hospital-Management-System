class AddColumnToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :cover, :string
  end
end
