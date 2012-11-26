# This migration comes from corkboard (originally 1)
class CreateCorkboardAuthorizations < ActiveRecord::Migration
  def change
    create_table :corkboard_authorizations, :force => true do |t|
      t.references :resource_owner, :polymorphic => { :default => 'User' }
      t.string     :provider,       :null => false
      t.string     :uid,            :null => false
      t.string     :token,          :null => false
      t.text       :info
      t.text       :extra
      t.timestamps
    end

    add_index :corkboard_authorizations, [:resource_owner_type, :resource_owner_id],
      :name => 'index_corkboard_authorizations_on_resource_owner'
    add_index :corkboard_authorizations, :provider
  end
end
