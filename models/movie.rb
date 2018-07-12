require_relative('star')
require_relative('../db/sql_runner')

class Movie
  attr_reader :id, :title, :genre, :budget
  attr_writer :title, :genre
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @budget = options['budget']
  end

  def stars()
    sql = "SELECT stars.* FROM stars
          INNER JOIN castings
	          ON stars.id = castings.star_id
          WHERE castings.movie_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    stars = result.map { |star| Star.new(star) }
    return stars
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM movies WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values)
    movie_hash = result.first
    return Movie.new(movie_hash)
  end
end
