class AddDurationToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :duration, :datetime
    add_column :events, :htmllink, :string
  end
end
