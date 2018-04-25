require_relative("../db/sql_runner")
require_relative("mixtape")

class Artist

attr_accessor :name
attr_reader :id

def initialize(option)
  @name = option["name"]
  @id = option["id"].to_i if option["id"]
end

def save()
  sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id "
  value = [@name]
  results = SqlRunner.run(sql, value)
  result1 = results.first
  @id = result1["id"].to_i
end

def albums()
    sql = "SELECT * FROM mixtapes
           WHERE artist_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    mixtapes = results.map{ |mixtape|
    Mixtape.new(mixtape)}
    return mixtapes
  end

def self.delete_all()
  sql = "DELETE FROM artists"
  SqlRunner.run(sql)
end



end
