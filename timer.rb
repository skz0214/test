# coding : SJIS
require 'win32/sound'
include Win32
task = []
message = []
thread_task = Thread.new do
	while input = gets.chomp.split
		case input[0]
		when "new"
			t = Time.now + input[2].to_i * 60
			task << [input[1],t]
		when "delete"
		when "all_delete"
			task = []
		when "show"
			p task
			p message
		when "end"
			break
		else
			t = Time.now + input[1].to_i * 60
			task << [input[0],t]
		end
	end
end
thread_min = Thread.new do
	while true
		puts message
		sleep 60
	end
end
thread_sec = Thread.new do
	while true
		t_now = Time.now
		message = []
		task.each do |val|
			x = val[1] - t_now
			if x < 0
				puts "#{val[0]} end"
				task.delete(val)
				Sound.play("SystemAsterisk",Sound::ALIAS)
			else
				message << "#{val[0]} : #{(x/3600).floor}ŽžŠÔ#{((x%3600)/60).floor}•ª#{(x%60).floor}•b"
			end	
		end
		sleep 1
	end
end
=begin
thread2 = Thread.new do
	1.times do
		p gets
	end

end
=end
#thread.join
thread_task.join
#thread2.join
