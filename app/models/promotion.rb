class Promotion < ActiveRecord::Base
  belongs_to :offer_sku
  belongs_to :offer_restriction
  belongs_to :offer_access
  belongs_to :sponsor
end
