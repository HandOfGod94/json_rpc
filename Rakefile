require "minitest/test_task"

Minitest::TestTask.create # named test, sensible defaults

# or more explicitly:

Minitest::TestTask.create(:test) do |t|
  t.libs << "specs"
  t.libs << "lib"
  t.warning = false
  t.test_globs = ["spec/**/*_spec.rb"]
end

task :default => :test