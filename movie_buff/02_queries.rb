def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between 3 and 5
  # (inclusive). Show the id, title, year, and score.

  Movie
    .select(:id, :title, :yr, :score)
    .where(yr: 1980..1989, score: 3..5)
  
end

def bad_years
  # List the years in which no movie with a rating above 8 was released.
  
  Movie
    .group(:yr)
    .having('MAX(score) < 8') # moral: havings have aggregates
    .pluck(:yr)

    #year 2000: 5 movies all 5 movies scores were < 8 
    #year 2001: 5 movies at least just one movie score was < 8 
    
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  
  # Sort the results by starring order (ord). Show the actor id and name.
  
  Actor
    .select(:id, :name)
    .joins(:movies)
    .where(movies: {title: title})
    .order('castings.ord')

end

def vanity_projects
  # List the title of all movies in which the director also appeared as the
  # starring actor. Show the movie id, title, and director's name.

  # Note: Directors appear in the 'actors' table.
  Movie
    .select(:id, :title, :name)
    .joins(:actors)
    .where('castings.ord = 1 AND castings.actor_id = movies.director_id')
end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name, and number of supporting roles.
  Actor
    .select(:id, :name, 'COUNT(*) AS roles')
    .joins(:castings)
    .where('castings.ord != 1')
    .group(:id)
    .order('roles DESC')
    .limit(2)

    # .select(:id, :name, 'COUNT(*) AS roles')
    # .joins(:castings)
    # .where.not(castings: {ord: 1})
    # .group(:id)
    # .order('roles DESC')
    # .limit(2)
  
end