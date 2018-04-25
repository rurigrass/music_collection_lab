require_relative("../db/sql_runner")
require_relative("artist")

class Mixtape

attr_accessor :title, :genre
attr_reader :id, :artist_id

def initialize(option)
  @title = option["title"]
  @genre = option["genre"]
  @id = option["id"].to_i if option["id"]
  @artist_id = option["artist_id"].to_i
end

def save()
  sql = "INSERT INTO mixtapes (title, genre, artist_id)
        VALUES ($1, $2, $3) RETURNING id "
  value = [@title, @genre, @artist_id]
  results = SqlRunner.run(sql, value)
  result1 = results.first
  @id = result1["id"].to_i
end

def self.delete_all()
  sql = "DELETE FROM mixtapes"
  SqlRunner.run(sql)
end

def self.all()
  sql = "SELECT * FROM mixtapes"
  mixtapes = SqlRunner.run(sql)
  mixtapes_array = mixtapes.map{ |mixtape| Mixtape.new(mixtape)}
  return mixtapes_array
end

def self.artist(id)
  sql = "SELECT * FROM mixtapes WHERE artist_id = $1"
  values = [id]
  results = SqlRunner.run(sql, values)
  mixtape_hash = results.first
  order = Mixtape.new(mixtape_hash)
  return order
end




end
