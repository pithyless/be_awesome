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

  def self.find_all(ids=[], opts={})
    ids = ids.map do |id|
      id.kind_of?(String) ? BSON::ObjectId.from_string(id) : id
    end
    query = {'_id' => {'$in' => ids}}
    query['type'] = opts[:post_type] if opts[:post_type]
    sort = [['created_at', Mongo::ASCENDING]]
    collection.find(query, :sort => sort).map do |data|
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
