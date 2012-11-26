class Corkboard::Authorization < ActiveRecord::Base
  @table_name = :corkboard_authorizations

  belongs_to :resource_owner

  attr_accessible :resource_owner, :provider, :uid, :token, :info, :extra
  serialize :info,  Hash
  serialize :extra, Hash

  def provider
    read_attribute(:provider).intern
  end
end
