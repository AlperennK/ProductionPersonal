class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 6, maximum: 100}
  validates :description, presence: true, length: { minimum: 6, maximum: 1000}
  belongs_to :user
end
#Active Record Validations
#https://guides.rubyonrails.org/active_record_validations.html