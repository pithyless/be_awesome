class Adventure
  attr_accessor :id, :status, :author_id, :created_at, :title,
    :active_pinger_ids, :supporter_ids, :post_ids

  attr_accessor :author_id

  def author
    @author = User.find(self.author_id)
  end

  def last_activity
    return @last_activity unless @last_activity.nil?
    last_post = Post.find_all(post_ids, post_type: 'author').last
    @last_activity = last_post ? last_post.created_at : created_at
  end

  def posts
    @posts ||= Post.find_all(post_ids)
  end

  def add_facebook_supporter(facebook_friend_id)
    if friend = User.find_by_facebook_uid(facebook_friend_id)
      self.class.collection.update({'_id' => self.id}, {
        "$addToSet" => {'supporter_ids' => friend.id}})
    else
      self.class.collection.update({'_id' => self.id}, {
        "$addToSet" => {'facebook_supporter_ids' => facebook_friend_id }})
    end
  end

  def active_pingers
    @active_pingers ||= [] # TODO!
  end

  def supporters
    @supporters ||= supporter_ids.map do |supporter_id|
      User.find(supporter_id)
    end
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

  def self.find_by_author(author, id)
    id = BSON::ObjectId.from_string(id) if id.kind_of?(String)
    if adv = collection.find({'author_id' => author.id, '_id' => id},
                   sort: [['created_at' => Mongo::ASCENDING]]).first
      self.from_mongo(adv)
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
      adv.created_at = hash['created_at']
      adv.status = hash['status']
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
