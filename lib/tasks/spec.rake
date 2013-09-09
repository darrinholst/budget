if defined?(RSpec)
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new do |t|
    t.pattern = 'spec/**/*_spec.rb'
  end
end

desc 'run javascript specs'
task 'spec:javascripts' do
  `bundle exec guard-jasmine -s thin`
  fail unless $? == 0
end

task :default => [:spec, "spec:javascripts"]
