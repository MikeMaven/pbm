class AddDefaultValueToRegionMotd < ActiveRecord::Migration[4.2]
  def up
    change_column_default :regions, :motd, 'To help keep Pinball Map running, consider a donation! https://pinballmap.com/donate'
  end

  def down
    change_column_default :regions, :motd, nil
  end
end
