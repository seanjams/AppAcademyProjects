class Album < ApplicationRecord
  has_many :tracks

  belongs_to :band, dependent: :destroy
end
