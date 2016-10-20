class Movie < ActiveRecord::Base
    
    public
    def getRatings()
       return :movies.pluck('DISTINCT rating') 
    end
end
