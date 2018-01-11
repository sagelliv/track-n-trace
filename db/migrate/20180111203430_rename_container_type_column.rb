class RenameContainerTypeColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :containers, :type, :container_type
  end
end
