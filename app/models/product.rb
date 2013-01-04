class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title

  validates :description, :image_url, :price, :title, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
      with:  %r{\.(gif|jpg|png)\Z}i, message:  'must be a valid URL you jerk'
  }
  validates :title, length: {minimum: 10, too_short: 'Oh come one...the title needs to be longer than that'}
end
