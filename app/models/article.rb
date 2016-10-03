class Article < ApplicationRecord
  acts_as_commentable
  validates :title, :body, presence: true
  validates :title, uniqueness: true
  has_many :taggings
  has_many :tags, through: :taggings
  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      #filter_letter = '(' + search + ')+' 
      Article.where(['lower(title) like ?', "%#{search.downcase}%"])
    else
      Article.all #全て表示。
    end
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).articles
  end

  def self.remove_tags(article_id)
  	Tagging.where(article_id: article_id).destroy_all
  end
end
