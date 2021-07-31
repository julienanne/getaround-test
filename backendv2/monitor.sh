files=$(find ./ -type f -name "*.rb")

echo "Monitoring..."
echo "$files"

clear

while true; do
  echo ""
  echo ""
  echo $(date)
  # bundle exec rspec # for all test but level incompatible
  bundle exec rspec --pattern spec/level1/*_spec.rb # for level1 tests
  bundle exec rspec --pattern spec/level2/*_spec.rb # for level2 tests
  bundle exec rspec --pattern spec/level3/*_spec.rb # for level3 tests
  # bundle exec rspec --pattern spec/level4/*_spec.rb # for level4 tests
  # bundle exec rspec --pattern spec/level5/*_spec.rb # for level5 tests
  inotifywait -qq -e close_write $files
done
