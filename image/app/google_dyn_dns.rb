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

require 'sinatra/base'
require_relative 'google_dyn_dns_thread'
require 'json'

class GoogleDynDNS < Sinatra::Base
  def raspberry_pi?
    !`uname -m`.index('arm').nil?
  end

  def application_directory
    File.expand_path File.dirname(__FILE__)
  end

  get '/active' do
    'ACTIVE'
  end

  get '/version' do
    begin
      body File.read("#{application_directory}/build_version.json")
    rescue
      response = {error: 'build_version not found'}
      body response.to_json
    end
  end

  get '/health' do
    status = GoogleDynDNSThread.instance.success? ? 'UP' : 'DOWN'
    {status: status}.to_json
  end

  get '/' do
    { last_update: GoogleDynDNSThread.instance.update_time.to_s }.to_json
  end
end
