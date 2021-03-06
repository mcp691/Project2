class Product < ApplicationRecord
  validates :name, :category, :image_url, presence: true
  has_many :orders
  has_many :comments

  def self.search(search_term)
    if Rails.env != "production"
      Product.where("name || category || description LIKE ?", "%#{search_term}%")
    else
      Product.where("name || category || description iLIKE ?", "%#{search_term}%")
    end

  end

  def highest_rating_comment
    comments.rating_desc.first
  end

  def average_rating
    comments.average(:rating).to_f
  end

end
