desc 'run javascript specs'
task 'spec:javascripts' do
  `bundle exec guard-jasmine`
  fail unless $? == 0
end

task :default => ['spec:javascripts']
