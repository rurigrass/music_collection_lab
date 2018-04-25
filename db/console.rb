require("pry")
require_relative("../models/artist")
require_relative("../models/mixtape")

Mixtape.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  "name" => "The Beatles"
})

  artist1.save

mixtape1 = Mixtape.new({
  "title" => "Abbey road",
  "genre" => "Rock",
  "artist_id" => artist1.id
  })

  mixtape1.save




binding.pry
nil
