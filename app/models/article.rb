class Article < ApplicationRecord
  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      filter_letter = '(' + search + ')+' 
      Article.where(['title ~* ?', "#{filter_letter}"])
    else
      Article.all #全て表示。
    end
  end
end
