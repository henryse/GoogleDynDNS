# **********************************************************************
#    Copyright (c) 2017 Henry Seurer & Samuel Kelly
#
#    Permission is hereby granted, free of charge, to any person
#    obtaining a copy of this software and associated documentation
#    files (the "Software"), to deal in the Software without
#    restriction, including without limitation the rights to use,
#    copy, modify, merge, publish, distribute, sublicense, and/or sell
#    copies of the Software, and to permit persons to whom the
#    Software is furnished to do so, subject to the following
#    conditions:
#
#    The above copyright notice and this permission notice shall be
#    included in all copies or substantial portions of the Software.
#
#    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
#    OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
#    HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
#    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
#    OTHER DEALINGS IN THE SOFTWARE.
#
# **********************************************************************

# config.ru (run with rackup)
require_relative 'google_dyn_dns'
require_relative 'google_dyn_dns_thread'
require 'logger'

run GoogleDynDNS

if File.exist?('/.dockerenv')
  Logger.new(STDOUT).info('Blue Pill: We are running in the matrix.')
  host = '0.0.0.0'
else
  Logger.new(STDOUT).info('Red Pill: We are running in real world')
  host = 'localhost'
end
secure_port = 8443

dyn_dns = GoogleDynDNSThread.instance

if dyn_dns.run
  # Run Secure Server
  GoogleDynDNS.run!(host: host, port: secure_port) do |server|
    working_directory = File.expand_path File.dirname(__FILE__)
    ssl_options = {
      cert_chain_file: "#{working_directory}/cert/https-wildcard.crt",
      private_key_file: "#{working_directory}/cert/https-wildcard.key",
      verify_peer: false
    }
    server.ssl = true
    server.ssl_options = ssl_options
  end
else
  Logger.new(STDERR).error('The processing thread is not running...
    exiting the program')
end

# use Rack::Static, :urls => ['/public'],
#     :root => File.expand_path(File.dirname(__FILE__)) + '/public'