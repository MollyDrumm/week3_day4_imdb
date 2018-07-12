require_relative('../db/sql_runner')

class Star
  attr_reader :id, :first_name, :last_name
  attr_writer :first_name, :last_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def movies
    sql = "SELECT movies.* FROM movies
    INNER JOIN castings
	  ON movies.id = castings.movie_id
    WHERE castings.star_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    movies = result.map { |movie| Movie.new(movie)
      }
    return movies
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM stars WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values)
    star_hash = result.first
    return Star.new(star_hash)
  end

end
