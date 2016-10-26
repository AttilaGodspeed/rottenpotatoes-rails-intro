class Movie < ActiveRecord::Base
    
    #public
    #def getRatings()
       #return :movies.pluck('DISTINCT rating')
       
       
  attr_accessible :title, :rating, :description, :release_date
  # Prefixing with 'self.' makes this a class method
  def self.get_possible_ratings
	return %w[G PG PG-13 R]
  end
end
