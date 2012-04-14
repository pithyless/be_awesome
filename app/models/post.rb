class Post
  attr_accessor :id, :created_at, :message

  def post_type
    raise NotImplementedError
  end

  def self.collection
    DB.collection('posts', :safe => true)
  end

  def self.find(id)
    id = BSON::ObjectId.from_string(id) if id.kind_of?(String)
    if data = collection.find({'_id' => id}).first
      self.from_mongo(data)
    end
  end

  def self.find_all(ids=[])
    ids = ids.map do |id|
      id = BSON::ObjectId.from_string(id) if id.kind_of?(String)
    end
    collection.find({'_id' => {'$in' => ids}}).map do |data|
      self.from_mongo(data)
    end
  end

  def self.from_mongo(hash)
    case hash['type']
    when 'author'
      AuthorPost.new(hash)
    end
  end

end
