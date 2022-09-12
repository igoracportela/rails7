module Addressable
  extend ActiveSupport::Concern

  included do
    has_many :addresses, as: :ownereable
  end
end