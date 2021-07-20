files=$(find ./ -type f -name "*.rb")

echo "Monitoring..."
echo "$files"

clear

while true; do
  echo ""
  echo ""
  echo $(date)
  bundle exec rspec
  inotifywait -qq -e close_write $files
done
