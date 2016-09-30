class AddIndexToEventGroupships < ActiveRecord::Migration[5.0]
  def change
  	add_index :event_groupships, :event_id
  	add_index :event_groupships, :group_id
  end
end
