class PingerPost < Post
  attr_accessor :pinger_ids

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
    'pinger'
  end

  def self.create(pingers, adventure)
    msg = if pingers.size > 1
            "#{pingers.size} were rewarded for their patience."
          else
            '1 person was rewarded for patience.'
          end

    id = self.collection.insert({
      type: post_type,
      created_at: Time.now,
      message: msg,
      pinger_ids: pingers.map { |p| p.id }
    })
    adventure.add_post_id(id)
    self.collection.find(id)
  end
end
