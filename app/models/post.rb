class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments

  validates :title, presence: true
  validates :category_id, presence: true
  validates :body, presence: true

  def self.search(query)
    where('title like ? OR body like ?', "%#{query}", "%#{query}")
  end

  has_attached_file :image, :default_url => ":style/image1.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end