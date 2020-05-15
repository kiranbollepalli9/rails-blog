class AddTimestapsToPost < ActiveRecord::Migration[6.0]
  def change
    add_timestamps(:posts)
  end
end
