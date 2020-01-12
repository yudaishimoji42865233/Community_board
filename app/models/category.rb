class Category < ActiveHash::Base
  include ActiveHash::Associations
  has_many :topics

  field :name 
  self.data = [
    {id: 1, name: '無し'}, 
    {id: 2, name: '募集'}, 
    {id: 3, name: '情報'},
    {id: 4, name: '質問'}, 
    {id: 5, name: '雑記'}, 
    {id: 6, name: '競売'}
  ]
end
