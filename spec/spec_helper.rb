$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..")
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "app", "controllers")
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "app", "models")

require 'factory_girl'
require 'jbuilder'
require 'ostruct'
require 'timeliness'
require 'models/mock_activerecord_base'
require 'controllers/mock_application_controller'

Dir["spec/factories/**/*.rb"].each {|f| require f}

