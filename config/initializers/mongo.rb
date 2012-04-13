if Rails.env.production?
  DB = Mongo::Connection.new(ENV['AWESOME_MONGO_HOST'], ENV['AWESOME_MONGO_PORT']).db('beawesome')
  DB.authenticate(ENV['AWESOME_MONGO_USER'], ENV['AWESOME_MONGO_SECRET'])
else
  DB = Mongo::Connection.new('localhost').db('beawesome')
end
