# encoding: utf-8
class AdventuresController < ApplicationController
  include ActionView::Helpers::DateHelper

  def supporters
    adv = Adventure.find(params.fetch(:id))
    supporters = adv.supporters.map do |s|
      {
        avatar_path: s.avatar,
        name: s.name
      }
    end

    if Rails.env.development?
      # TODO: hack!
      supporters = [
        { avatar_path: "http://graph.facebook.com/1180408451/picture?type=square",
        name: "Krzysiek Urbas" },
        { avatar_path: "http://graph.facebook.com/523823416/picture?type=square",
        name: "Mateusz Wiktor" }
      ]
    end

    data = {
      title: adv.title,
      supporters: supporters,
      invite_supporters_url: adv.new_supporters_invite_url
    }

    render :json => data.to_json
   end

  def create
    data = {
      title: params.fetch(:title)
    }
    adv = Adventure.create(current_user, data)
    render :json => { status: 'OK', adventure_id: adv.id.to_s }
  end

  def create_post
    data = {
      message: params.fetch(:message)
    }
    adv  = Adventure.find(params.fetch(:adventure_id)) # TODO: authorize gently
    post = AuthorPost.create(current_user, adv, data)
    render :json => { status: 'OK', adventure_id: adv.id.to_s }
  end

  def supportings
    adventures = Adventure.find_all_by_supporter(current_user).map do |adv|
      {
        id: adv.id.to_s,
        title: adv.title,
        status: adv.status,
        avatar_path: adv.author.avatar,
        active_pingers_count: adv.active_pinger_ids.size,
        last_activity_days: time_ago_in_words(adv.last_activity)
       }
    end

    render :json => adventures.to_json
  end

  def index
    adventures = Adventure.find_all_by_author(current_user).map do |adv|
      {
        id: adv.id.to_s,
        title: adv.title,
        status: adv.status,
        avatar_path: adv.author.avatar,
        active_pingers_count: adv.active_pinger_ids.size,
        last_activity_days: time_ago_in_words(adv.last_activity)
       }
    end

    render :json => adventures.to_json
  end

  def show
    adv = Adventure.find_by_author_or_supporter(current_user, params.fetch(:id))

    adventure = {
      title: adv.title,
      status: adv.status,
      current_user_avatar: current_user.avatar,
      adventure_id: adv.id.to_s,
      active_pingers_count: adv.active_pingers.size,
      active_pingers: adv.active_pingers.map do |p|
        { avatar_path: p.avatar,
          name: p.name }
      end,
      supporters_count: adv.supporters.size,
      supporters: adv.supporters.map do |p|
        { avatar_path: p.avatar,
          name: p.name }
      end,
      posts: adv.posts.map do |p|
        {
          type: p.post_type,
          created_at: p.created_at,
          body: p.message,
          author: {
            avatar_path: p.author.avatar,
            name: p.author.name
          }
        }
      end
    }
    render :json => adventure.to_json
  end

  def add_supporters_callback
    adv = Adventure.find_by_author(current_user, params.fetch(:adventure_id))
    facebook_friend_ids = params.fetch(:to)

    facebook_friend_ids.each do |_, facebook_friend_id|
      adv.add_facebook_supporter(facebook_friend_id)
    end
    redirect_to root_path
  end

end
