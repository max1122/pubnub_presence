class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :init_subscribe, :only => :index

  def index
    @users = User.all    
  end

  def unsubscribe
    if request.xhr?
      pubnub = Pubnub.new(
        :publish_key   => PUBLISH_KEY,
        :subscribe_key => SUBSCRIBE_KEY,
        :uuid => current_user.email
      )

      pubnub.subscribe(
          :channel  => 'pubnub_room'
        ) { |data| puts data.msg }

      pubnub.unsubscribe(
        :channel  => 'pubnub_room'
      ) { |data| puts data.msg }

      render :json => {status: 200}
    end
  end

  def subscribe
    if request.xhr? 
      pubnub = Pubnub.new(
        :publish_key   => PUBLISH_KEY,
        :subscribe_key => SUBSCRIBE_KEY,
        :uuid => current_user.email
      )

      pubnub.subscribe(
        :channel  => 'pubnub_room'
      ) { |data| puts data.msg }

      render :json => {status: 200}
    end
  end

  def status_monitor
    render :json => User.all
  end

  private

  def init_subscribe
     pubnub = Pubnub.new(
        :publish_key   => PUBLISH_KEY,
        :subscribe_key => SUBSCRIBE_KEY,
        :uuid => current_user.email
      )

      pubnub.subscribe(
        :channel  => 'pubnub_room'
      ) { |data| puts data.msg }

      pubnub.presence(
        :channel  => 'pubnub_room'
      ) { |envelope| 
        if envelope.msg['uuid'] && envelope.msg['action']
          user = User.find_by_email(envelope.msg["uuid"])
          user.status = envelope.msg["action"]
          user.save
        end
      }
  end
end