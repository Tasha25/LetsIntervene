class ServiceCategory < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :service_providers

  validates :name, :presence => true
end
