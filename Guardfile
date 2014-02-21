group 'fast specs' do
  guard 'rspec', :bundler => false do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^app/(.+)\.rb$})           { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^spec/support/(.+)\.rb$})  { "spec" }
    watch('spec/spec_helper.rb')        { "spec" }
  end
end

group 'slow specs' do
  guard 'rspec', :bundler => false, :spec_paths => ['spec_slow'] do
    watch(%r{^spec_slow/.+_spec\.rb$})
    watch(%r{^spec_slow/support/(.+)\.rb$})  { "spec" }
    watch('spec_slow/spec_helper.rb')        { "spec" }
  end
end

group 'javascript tests' do
  guard 'jasmine', :server => :thin do
    watch(%r{(?:app|lib)/assets/javascripts/(.+?)\.(js\.coffee|js|coffee)$}) { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
    watch(%r{spec/javascripts/(.+)_spec\.(js\.coffee|js|coffee)$})           { |m| m[0] }
    watch(%r{spec/javascripts/helpers/(.+?)\.(js\.coffee|js|coffee)$})       { "spec/javascripts" }
    watch(%r{spec/javascripts/spec\.(js\.coffee|js|coffee)$})                { "spec/javascripts" }
  end
end

