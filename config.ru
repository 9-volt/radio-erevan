require File.join(File.dirname(__FILE__), 'dashboard/dash')

set :run, false
set :environment, :production

FileUtils.mkdir_p 'logs' unless File.exists?('logs')
log = File.new("logs/sinatra.log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)

run Dash
