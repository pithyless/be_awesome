class AuthorPost < Post
  attr_accessor :author_id

  def author
    @author = User.find(self.author_id)
  end

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

  def post_type
    self.class.post_type
  end

  def self.post_type
    'author'
  end

  def self.create(author, adventure, data={})
    fail 'Forbidden' if adventure.author_id != author.id

    id = self.collection.insert({
      type: post_type,
      author_id: author.id,
      created_at: Time.now,
      message: data.fetch(:message)
    })
    adventure.add_post_id(id)
    self.collection.find(id)
  end
end
