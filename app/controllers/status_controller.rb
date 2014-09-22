require 'reloader/sse'

class StatusController < ApplicationController
  include ActionController::Live

  def index
    # SSE expects the `text/event-stream` content type
    response.headers['Content-Type'] = 'text/event-stream'

    sse = Reloader::SSE.new(response.stream)
    
    begin
      sse.write({ :data => "ok" }, :event => 'initial')
       
      $pubnub.here_now(
        :channel  => 'pubnub_room'
      ) { |envelope| 
        puts envelope.msg
        sse.write(envelope.msg['uuids'], :event => 'here_now')
      }

      $pubnub.presence(
        :channel  => 'pubnub_room'
      ) { |envelope|
        if envelope.msg['uuid'] && envelope.msg['action']
          puts envelope.msg
          sse.write([envelope.msg['uuid'], envelope.msg['action']], :event => 'presence')
        end
      }
    rescue IOError
      # When the client disconnects, we'll get an IOError on write
    ensure
      # sse.close
    end
  end
end
