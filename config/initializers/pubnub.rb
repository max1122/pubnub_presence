PUBLISH_KEY = 'demo'
SUBSCRIBE_KEY = 'demo'

$callback = lambda do |envelope|
	puts 'step init 1'
	puts envelope.msg
  if envelope.msg['uuid'] && envelope.msg['action']
  	puts 'step init 2'
	  user = User.find_by_email(envelope.msg["uuid"])
	  user.status = envelope.msg["action"]
	  user.save
  end
  puts 'step init 3'
end
