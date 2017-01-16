require 'rest-client'
require 'yaml'
require 'ostruct'
require 'optparse'

def load(config_path)
  config_info = YAML.load_file("#{config_path}")
  username = config_info['dyndns']['username']
  password = config_info['dyndns']['password']
  domain_name = config_info['dyndns']['domain_name']
  time = config_info['dyndns']['seconds']
  "https://#{username}:#{password}@domains.google.com/nic/update?hostname=#{domain_name}"
end

def client_call(url_path)
  while true
    response = RestClient.get("#{url_path}")
    puts response.body
    sleep(60*60)
  end
end

# Parse Command Line Options
#
options = OpenStruct.new
options.config = 'config.yaml'
options.daemon = false

opt_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: dyn_dns.rb [options]'

  opts.on('--config=config', String, 'File Path to YAML File') do |config|
    options.config = config
  end
  opts.on('--daemonize=DAEMONIZE', String, 'Run as a daemon') do |daemon|
    options.daemon = daemon.downcase == 'true'
  end
end

opt_parser.parse!

# Check to see if we have valid inputs:

# If we have a "version" then we need to have an Image
#

Process.daemon if options.daemon

url = load(options.config)
client_call(url)
