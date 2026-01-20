# Sajans Migrations

This folder contains migration scripts for **Sajans**. Migrations are used to update configuration, apply new features, or modify system/user files in a controlled and sequential manner.

Each migration is a standalone Bash script that is automatically executed by the migration runner when it has not yet been applied.

---

## Migration System Overview

The migration system works using **sequential numeric IDs** in the filenames, rather than Git commit timestamps. This ensures that migrations run **in the correct order**, regardless of when they were created or committed.

* Each migration filename starts with a **three-digit number** followed by a short description.
* Example:

```
001-initial-setup.sh
002-add-config.sh
003-update-theme.sh
```

The numeric prefix determines the execution order. Migrations with smaller numbers run first.

---

## How Migrations are Run

1. The migration runner checks all scripts in this folder.
2. It determines the **last applied migration** (tracked via a number or a `.migrations` file).
3. It executes **any migration that has not yet been applied**, in ascending order.
4. After running, the migration is marked as applied so it does not run again.

> **Important:** Only the numeric prefix determines whether a migration should run. Do not rely on Git commit timestamps.

---

## Creating a New Migration

To add a new migration:

1. Determine the next available sequential number.

   * Example: If the last migration is `003-update-theme.sh`, the next migration should start with `004-`.

2. Create a new shell script in this folder:

```bash
touch 004-my-migration.sh
chmod +x 004-my-migration.sh
```

3. Add your migration commands. For example:

```bash
#!/bin/bash
# Example migration: add a new config file
cp "$SAJANS_UBUNTU_PATH/config/default.conf" "$HOME/.config/sajans.ubuntu/config.conf"
```

4. Commit the migration to Git. After a `git pull`, the migration runner will automatically execute it if it has not already run.

---

## Best Practices

* **Do not skip numbers** — maintain sequential order to prevent migrations from being applied out of order.
* **Make migrations idempotent** — they should be safe to run even if partially applied.
* **Keep scripts self-contained** — each migration should not rely on other migrations being run in the same script.
* **Use descriptive filenames** — the number alone determines order, but the description helps understand what the migration does.

---

## Example Migration Template

```bash
#!/bin/bash
# 004-my-migration.sh
# Description: <Short description of what this migration does>

echo "Running migration 004-my-migration.sh"

# Example commands:
# Copy configuration file
cp "$SAJANS_UBUNTU_PATH/config/default.conf" "$HOME/.config/sajans.ubuntu/config.conf"

# Additional commands here
```

> Save this template and update the number and description for each new migration.

---

With this system, your migrations are **predictable, safe, and easy to manage**, regardless of when they are generated or committed.
