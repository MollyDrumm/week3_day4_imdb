require_relative('../db/sql_runner')

class Casting
  attr_reader :id, :movie_id, :star_id, :fee
  attr_writer :fee

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id'].to_i
    @star_id = options['star_id'].to_i
    @fee = options['fee'].to_i
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM castings WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values)
    casting_hash = result.first
    return Casting.new(casting_hash)
  end

end
