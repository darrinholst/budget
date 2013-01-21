group 'fast specs' do
  guard 'rspec', :bundler => false do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^app/(.+)\.rb$})           { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^spec/support/(.+)\.rb$})  { "spec" }
    watch('spec/spec_helper.rb')        { "spec" }
  end
end

