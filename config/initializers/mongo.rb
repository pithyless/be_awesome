if Rails.env.production?
  DB = Mongo::Connection.new(ENV['AWESOME_MONGO_HOST'], ENV['AWESOME_MONGO_PORT']).db('beawesome')
  DB.authenticate(ENV['AWESOME_MONGO_USER'], ENV['AWESOME_MONGO_SECRET'])
else
  DB = Mongo::Connection.new('localhost').db('beawesome')
end

DB.collection('users').ensure_index([['facebook_uid', Mongo::ASCENDING]])
DB.collection('posts').ensure_index([['created_at', Mongo::ASCENDING]])
DB.collection('adventures').ensure_index([['author_id', Mongo::ASCENDING]])
