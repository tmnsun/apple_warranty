require 'codeclimate-test-reporter'
require 'simplecov'
require 'byebug'
require 'webmock/rspec'

module SimpleCov::Configuration
  def clean_filters
    @filters = []
  end
end

WebMock.disable_net_connect!(allow_localhost: true, allow: 'codeclimate.com')

SimpleCov.configure do
  load_profile 'test_frameworks'
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
]

ENV["COVERAGE"] && SimpleCov.start do
  add_filter "/.rvm/"
end
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'AppleWarranty/scraper'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

end
