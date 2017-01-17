require 'rest-client'
require 'yaml'
require 'ostruct'
require 'optparse'

def load(config_file)
  config_info = YAML.load_file("#{config_file}")
  username = config_info['dyndns']['username']
  password = config_info['dyndns']['password']
  domain_name = config_info['dyndns']['domain_name']
  time = config_info['dyndns']['seconds']
  return time, "https://#{username}:#{password}@domains.google.com/nic/update?hostname=#{domain_name}"
end

def client_call(time, url_path)
  while true
    response = RestClient.get(url_path)
    puts response.body
    sleep(time)
  end
end

# Parse Command Line Options
#
options = OpenStruct.new
options.config = '/opt/dyndns.yml'
options.daemon = false

opt_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: dyn_dns.rb [options]'

  opts.on('--config=config', String, 'File Path to YAML File') do |config|
    options.config = config
  end
  opts.on('--daemonize=DAEMONIZE', String, 'Run as a daemon, true or false') do |daemon|
    options.daemon = daemon.downcase == 'true'
  end
end

opt_parser.parse!

# should we run as a daemon?
Process.daemon if options.daemon

# noinspection RubyResolve
time, url = load(options.config)
client_call(time, url)
