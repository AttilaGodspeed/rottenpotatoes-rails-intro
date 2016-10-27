class Movie < ActiveRecord::Base
 #defining these here makes the records dissapear, apparently
 #attr_accessor :title, :rating, :description, :release_date
  # Prefixing with 'self.' makes this a class method
  def self.get_possible_ratings
	return %w[G PG PG-13 R]
	#return :movies.pluck('DISTINCT rating')
  end
end
