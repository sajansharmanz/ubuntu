cd $SAJANS_UBUNTU_PATH || exit 1
last_applied=$(cat $SAJANS_UBUNTU_PATH/.migrations 2>/dev/null || echo 0)

if ! git pull --ff-only; then
  echo "git pull failed (non-fast-forward or local changes). Resolve and retry."
  exit 1
fi

for file in $(ls $SAJANS_UBUNTU_PATH/migrations/*.sh | sort); do
  migrate_id=$(basename "$file" | cut -d- -f1)

  if [ "$migrate_id" -gt "$last_applied" ]; then
    echo "Running migration $file"
    source "$file"
    echo "$migrate_id" > $SAJANS_UBUNTU_PATH/.migrations
  fi

done
