# More info at https://github.com/guard/guard#readme

guard :rspec, cmd: 'bundle exec rspec', all_on_start: true do
  watch(%r{lib/(.+).rb}) { |m| "spec/#{m[1]}_spec.rb" }
end
