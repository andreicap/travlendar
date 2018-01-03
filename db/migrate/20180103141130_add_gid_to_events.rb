class AddGidToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :gid, :string
  end
end
