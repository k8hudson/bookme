class AddProviderIdAndUserIdToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :provider_id, :integer
  	add_column :events, :user_id, :integer
  	remove_column :events, :title
  	remove_column :events, :description
  end
end
