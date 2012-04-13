# encoding: utf-8
class AdventuresController < ApplicationController

  def show
    avatar = 'https://en.gravatar.com/userimage/11590901/c59c95d70942a008aa92adc5ed3c7637.jpg?size=50'

    adventure = {
      title: 'My First Bicycle Ride',
      status: 'active',
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
