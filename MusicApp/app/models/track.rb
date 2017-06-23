class Track < ApplicationRecord
  belongs_to :album, dependent: :destroy
end
