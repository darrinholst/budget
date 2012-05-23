$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..")
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "app", "controllers")
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "app", "models")

Dir["spec/support/**/*.rb"].each {|f| require f}
require 'controllers/mock_application_controller'


