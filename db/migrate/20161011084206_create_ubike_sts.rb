class CreateUbikeSts < ActiveRecord::Migration[5.0]
  def change
    create_table :ubike_sts do |t|
    	t.string :iid
    	t.string :station
    	t.string :ubike_count
    	t.string :address
    	
      t.timestamps
    end
  end
end
