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

require_relative 'config'
require 'rest-client'
require 'logger'
require 'thread'
require 'singleton'

class GoogleDynDNSThread
  include Singleton

  def alive?
    @thread.alive?
  end

  def success?
    @success
  end
  # noinspection RubyResolve
  def run
    @success = false
    @thread = Thread.new do
      config = Config.new
      if config.load(File.join(File.dirname(__FILE__), 'config', 'config.yml'))
        request = "https://#{config.username}:#{config.password}@domains.google.com/nic/update?hostname=#{config.domain_name}"

        while true
          response = RestClient.get(request)

          @success = response.code == 200
          if @success
            Logger.new(STDOUT).info("Received #{response.code} connecting to domains.google.com/nic/update?hostname=#{config.domain_name}")
          else
            Logger.new(STDERR).error("Error #{response.code} connecting to domains.google.com/nic/update?hostname=#{config.domain_name}")
          end

          sleep(config.sleep_seconds)
        end
      end
    end

    sleep 10
    alive?
  end
end