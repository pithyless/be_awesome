# encoding: utf-8
class AdventuresController < ApplicationController

  def create_adventure
    data = {
      title: params.fetch(:title)
    }
    adv = Adventure.create(current_user, data)
    render :json => { status: 'OK' }
  end

  def create_post
    data = {
      message: params.fetch(:message)
    }
    adv  = Adventure.find(params.fetch(:adventure_id)) # TODO: authorize gently
    post = AuthorPost.create(current_user, adv, data)
    render :json => { status: 'OK' }
  end

  def index
    adventures = [
      {
        title: 'My First Bicycle Ride',
        status: 'active',
        active_pingers_count: 3,
        last_activity_days: 0,
        id: 1
      },
      {
        title: 'My Second Adventure',
        status: 'active',
        active_pingers_count: 0,
        last_activity_days: 9,
        id: 2
      },
    ]

    render :json => adventures.to_json
  end

  def show
    avatar = 'http://profile.ak.fbcdn.net/hprofile-ak-snc4/573520_1180408451_1360557398_q.jpg'

    adventure = {
      title: 'My First Bicycle Ride',
      status: 'active',
      adventure_id: '1',
      active_pingers_count: 3,
      active_pingers: [
        {
          avatar_path: avatar,
          name: 'Mateusz Wiktor',
        },
        {
          avatar_path: avatar,
          name: 'Mateusz Wiktor',
        },
        {
          avatar_path: avatar,
          name: 'Mateusz Wiktor',
        }
      ],
      supporters_count: 3,
      supporters: [
        {
          avatar_path: avatar,
          name: 'Mateusz Wiktor',
        },
        {
          avatar_path: avatar,
          name: 'Mateusz Wiktor',
        },
        {
          avatar_path: avatar,
          name: 'Mateusz Wiktor',
        }
      ],
      posts: [
        {
          type: 'author',
          created_at: Date.today - 1,
          body: 'All about my ride.',
          author: {
            avatar_path: avatar,
            name: 'Norbert Wójtowicz'
          }
        },
        {
          type: 'supporter',
          created_at: Date.today,
          body: 'Good Job!',
          author: {
            avatar_path: avatar,
            name: 'Krzysztof Urbas'
          }
        },
        {
          type: 'pingers',
          created_at: Date.today,
          pingers_count: '1',
          pingers: [
            {
              avatar_path: avatar,
              name: 'Krzysztof Urbas'
            }
          ]
        },
        {
          type: 'author',
          created_at: Date.today - 1,
          body: 'Huzzah!',
          author: {
            avatar_path: avatar,
            name: 'Norbert Wójtowicz'
          }
        }
       ]
    }
    render :json => adventure.to_json
  end

end
