files=$(find ./ -type f -name "*.rb")

echo "Monitoring..."
echo "$files"

clear

while true; do
  echo ""
  echo ""
  echo $(date)
  # bundle exec rspec # for all test but level incompatible
  bundle exec rspec --pattern spec/level2/*_spec.rb # for level2 tests
  inotifywait -qq -e close_write $files
done
