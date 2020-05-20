class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(column, search)
    return all unless search
    where(["#{column} LIKE ?", "%#{search}%"])
  end
end
