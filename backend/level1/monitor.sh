files=$(find ./ -type f -name "*.rb")

echo "Monitoring..."
echo "$files"

clear

while true; do
  echo ""
  echo ""
  echo $(date)
  ruby tests.rb
  inotifywait -qq -e close_write $files
done
