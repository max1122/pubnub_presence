class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :init_subscribe, :only => :index

  def index
    @users = User.all    
  end

  private

  def init_subscribe
     $pubnub = Pubnub.new(
        :publish_key   => PUBLISH_KEY,
        :subscribe_key => SUBSCRIBE_KEY,
        :uuid => current_user.email
      )

      $pubnub.subscribe(
        :channel  => 'pubnub_room'
      ) { |data| puts data.msg }
  end
end