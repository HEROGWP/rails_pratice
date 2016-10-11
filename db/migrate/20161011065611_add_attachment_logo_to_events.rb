class AddAttachmentLogoToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :events, :logo
  end
end
