class User
  attr_accessor :id, :email, :name, :avatar, :facebook_access_token

  def adventures
    @adventures ||= Adventure.find_all_by_author(self)
  end


  def self.collection
    DB.collection('users')
  end

  def self.all
    collection.find({}).map do |user|
      self.from_mongo(user)
    end
  end

  def self.find(id)
    id = BSON::ObjectId.from_string(id) if id.kind_of?(String)
    if user = collection.find({'_id' => id}).first
      self.from_mongo(user)
    end
  end

  def self.login_via_facebook(auth)
    user = User.find_by_facebook_uid(auth["uid"]) || User.create_with_facebook(auth)
    collection.update({'_id' => user.id}, {"$set" => { 'facebook_access_token' => auth.credentials.token, 'facebook_expires_at' => auth.credentials.expires_at }})
    user
  end

  def self.find_by_facebook_uid(uid)
    if user = collection.find({'facebook_uid' => uid}).first
      self.from_mongo(user)
    end
  end

  def self.find_all(ids)
    collection.find({'_id' => id}, {"$push" => {'post_ids' => post_id}}).map do |data|
      self.from_mongo(data)
    end
  end

  def self.from_mongo(data)
    self.new.tap do |u|
      u.id     = data['_id']
      u.email  = data['email']
      u.name   = data['name']
      u.avatar = data['avatar']
      u.facebook_access_token = data['facebook_access_token']
    end
  end

  def self.create_with_facebook(auth)
    facebook_uid = auth.uid
    email = auth.info.email
    name = auth.info.name
    avatar = auth.info.image

    collection.insert({
      facebook_uid: facebook_uid,
      email: email,
      name: name,
      avatar: avatar
    })
    self.find_by_facebook_uid(facebook_uid)
  end
end
