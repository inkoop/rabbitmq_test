require "rubygems"
require "bunny"

STDOUT.sync = true

conn = Bunny.new("amqp://guest:guest@localhost:5672")
conn.start

ch  = conn.create_channel
x   = ch.fanout("nba.scores")

q = ch.queue("joe", :auto_delete => true).bind(x)

# 100.times do |i|
#   q.subscribe do |delivery_info, metadata, payload|
#     puts "#{payload} => joe #{i}"
#   end
# end

# q.subscribe do |delivery_info, metadata, payload|
#   puts "#{payload} => joe 2"
#   # sleep 4
# end

# q.subscribe do |delivery_info, metadata, payload|
#   puts "#{payload} => joe 3"
#   # sleep 4
# end

x.publish("1").publish("2").publish("3").publish("4").publish("5")


sleep 60
conn.close
