class AddAsmGroupIdToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :asm_group_id, :integer, :limit => 2
  end
end
