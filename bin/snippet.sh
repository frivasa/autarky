IFS='-' read -A parts <<< "$1"

echo $parts[1]  # prints "part3"

