if defined?(RSpec)
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new do |t|
    t.pattern = 'spec/**/*_spec.rb'
  end

  RSpec::Core::RakeTask.new('spec:slow') do |t|
    t.pattern = 'spec_slow/**/*_spec.rb'
  end
end

desc 'run javascript specs'
task 'spec:javascripts' do
  `bundle exec guard-jasmine`
  fail unless $? == 0
end

task :default => [:spec, "spec:javascripts"]
