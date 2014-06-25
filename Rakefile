require 'bundler/setup'

namespace :style do
  require 'cane/rake_task'
  desc 'Run Ruby metrics checks'
  Cane::RakeTask.new(:cane)

  require 'foodcritic'
  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef)
end

desc 'Run all style checks'
task style: ['style:chef', 'style:cane']

# require 'rspec/core/rake_task'
# RSpec::Core::RakeTask.new(:spec) do |t, args|
#   t.rspec_opts = '--color --format=documentation test/unit/spec'
# end


begin
  require 'kitchen'
  SafeYAML::OPTIONS[:default_mode] = :unsafe if defined?(SafeYAML)
  desc 'Run Test Kitchen integration tests'
  task :integration do
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end
rescue LoadError => ignore_kitchen_in_ci
  puts "error: kitchen gem not loaded" unless ENV['CI']
end

namespace :travis do
  desc 'Run tests on Travis'
  task ci: ['style']
end

# The default rake task should just run it all
task default: ['style', 'integration']
