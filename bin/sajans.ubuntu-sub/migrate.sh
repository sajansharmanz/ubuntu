cd $SAJANS_UBUNTU_PATH
last_applied=$(cat $SAJANS_UBUNTU_PATH/.migrations 2>/dev/null || echo 0)
git pull

for file in $(ls $SAJANS_UBUNTU_PATH/migrations/*.sh | sort); do
  migrate_id=$(basename "$file" | cut -d- -f1)

  if [ "$migrate_id" -gt "$last_applied" ]; then
    echo "Running migration $file"
    source "$file"
    echo "$migrate_id" > $SAJANS_UBUNTU_PATH/.migrations
  fi

done
