if defined?(RSpec)
  Spec::Rake::SpecTask.new do |t|
    t.pattern = 'spec/**/*_spec.rb'
  end
end

desc 'run javascript specs'
task 'spec:javascripts' do
  `bundle exec guard-jasmine -s thin`
  fail unless $? == 0
end

task :default => [:spec, "spec:javascripts"]
