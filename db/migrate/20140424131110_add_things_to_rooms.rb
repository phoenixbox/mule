class AddThingsToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :name, :string, default: ""
    add_column :rooms, :style, :string, default: ""
    add_column :rooms, :beds, :integer, default: 0
    add_column :rooms, :tables, :integer, default: 0
    add_column :rooms, :chairs, :integer, default: 0
    add_column :rooms, :electronics, :integer, default: 0
    add_column :rooms, :accessories, :integer, default: 0
  end
end
