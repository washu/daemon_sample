# This background thread will just sleep in a loop
@t = Thread.new do 
  loop {
    sleep 1
  }
end
puts "BG Thread id is #{@t}"
puts "Pre Thread List"
Thread.list.each do |t|
  puts "Thread #{t.inspect}"
end
  

puts "About to Daemonize"
Process.daemon(true,true)

puts "Now in Daemon Mode"


Thread.new do
  count = 0
  loop do
    count += 1
    sleep 1
    puts "\n *** Live Threads ***"
    Thread.list.each do |t|
      if t == Thread.current
        puts "Self #{t.inspect}"
      else  
        puts "Thread #{t.inspect}"
      end
    end
    puts "\t BG is #{@t.inspect}"
    if count > 5
      puts "Test Complete"
      exit
    end
  end
end.join


