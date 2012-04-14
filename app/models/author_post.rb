class AuthorPost < Post
  def initialize(attrs={})
    attrs.each do |key, val|
      if key == 'type'
        next
      elsif key == '_id'
        self.id = val
      else
        send("#{key}=", val)
      end
    end
  end

  def self.post_type
    'author'
  end

  def self.create(author, adventure, data={})
    fail 'Forbidden' if adventure.author_id != author.id

    id = self.collection.insert({
      type: post_type,
      created_at: Time.now,
      message: data.fetch(:message)
    })
    adventure.add_post_id(id)
    self.collection.find(id)
  end
end
