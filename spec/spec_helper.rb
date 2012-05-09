$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..")
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "app")

Dir["spec/support/**/*.rb"].each {|f| require f}
require 'controllers/mock_application_controller'


