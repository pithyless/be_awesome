class User
  attr_accessor :id, :email, :name, :avatar

  def self.collection
    DB.collection('users')
  end

  def self.find(id)
    if user = collection.find({_id: id}).first
      self.new.tap do |u|
        u.id     = user['_id']
        u.email  = user['email']
        u.name   = user['name']
        u.avatar = user['avatar']
      end
    end
  end

  def self.find_by_facebook_uid(uid)
    if user = collection.find({facebook_uid: uid}).first
      self.new.tap do |u|
        u.id     = user['_id']
        u.email  = user['email']
        u.name   = user['name']
        u.avatar = user['avatar']
      end
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
