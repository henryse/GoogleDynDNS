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

require 'yaml'
require 'ostruct'
require 'logger'

# noinspection ALL
class Config < OpenStruct
  def load(config_file)
    begin
      config_info = YAML.load_file(config_file)
      self.username = config_info['dyndns']['username']
      self.password = config_info['dyndns']['password']
      self.domain_name = config_info['dyndns']['domain_name']
      self.sleep_seconds = config_info['dyndns']['sleep_seconds']
    rescue
      Logger.new(STDERR).error('Unable to load the config file.')
      return false
    end

    true
  end
end