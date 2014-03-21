class Import < ActiveRecord::Base
	include PublicActivity::Model
  tracked
end
