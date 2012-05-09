if defined?(RSpec)
  Spec::Rake::SpecTask.new do |t|
    t.pattern = 'spec/**/*_spec.rb'
  end
end

