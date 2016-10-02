class Article < ApplicationRecord
  acts_as_commentable
  validates :title, :body, presence: true
  validates :title, uniqueness: true
  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      #filter_letter = '(' + search + ')+' 
      Article.where(['lower(title) like ?', "%#{search.downcase}%"])
    else
      Article.all #全て表示。
    end
  end
end
