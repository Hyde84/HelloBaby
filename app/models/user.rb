class User < ActiveRecord::Base
  has_many :services, :dependent => :destroy
  has_many :audios, :dependent => :destroy
end
