class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(column, str, type)
    return all unless str
    case type
    when "forward"
      where(["#{column} LIKE ?", "#{str}%"])
    when "backward"
      where(["#{column} LIKE ?", "%#{str}"])
    when "partial"
      where(["#{column} LIKE ?", "%#{str}%"])
    when "exact"
      where(["#{column} LIKE ?", "#{str}"])
    else
    end
  end
end
