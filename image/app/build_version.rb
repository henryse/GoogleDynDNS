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

require 'json'
require 'fileutils'
require 'optparse'
require 'securerandom'

version = SecureRandom.uuid.delete! '-'

opt_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: build_version.rb [options]'

  opts.on('--version=VERSION', String,
          'Build version, default is random UUID will be generated.') do |item|
    version = item
  end
end
opt_parser.parse!

build_date_time = Time.new.strftime '%Y-%m-%d_%H:%M:%S'
json_object = { version: version, build_time: build_date_time }

working_directory = File.expand_path File.dirname(__FILE__)

file = File.open("#{working_directory}/build_version.json", 'w')
file.write(json_object.to_json.to_s)
file.close