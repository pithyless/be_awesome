class Adventure
  attr_accessor :id, :status, :author_id, :created_at, :title,
    :active_pinger_ids, :supporter_ids, :post_ids

  def last_activity_days
    return @last_activity_days unless @last_activity_days.nil?
    time = Post.find_all(post_ids, post_type: 'author').last.created_at
    day = Date.new(time.year, time.month, time.day)
    @last_activity_days = (Date.today - day).to_i
  end

  def posts
    @posts ||= Post.find_all(post_ids)
  end

  def add_post_id(post_id)
    self.class.collection.update({'_id' => id}, {"$push" => {'post_ids' => post_id}})
  end

  def self.collection
    DB.collection('adventures', :safe => true)
  end

  def self.find(id)
    id = BSON::ObjectId.from_string(id) if id.kind_of?(String)
    if data = collection.find({'_id' => id}).first
      self.from_mongo(data)
    end
  end

  def self.find_all_by_author(author)
    collection.find({'author_id' => author.id}).map do |data|
      self.from_mongo(data)
    end
  end

  def self.from_mongo(hash)
    self.new.tap do |adv|
      adv.id = hash['_id']
      adv.author_id = hash['author_id']
      adv.title = hash['title']
      adv.active_pinger_ids = hash['active_pinger_ids']
      adv.supporter_ids = hash['supporter_ids']
      adv.post_ids = hash['post_ids']
    end
  end

  def self.create(author, data={})
    id = self.collection.insert({
      created_at: Time.now,
      status: 'active',
      author_id: author.id,
      title: data.fetch(:title),
      active_pinger_ids: [],
      supporter_ids: [],
      post_ids: []
    })
    self.find(id)
  end

end
