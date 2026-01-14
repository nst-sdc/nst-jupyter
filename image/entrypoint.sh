#!/usr/bin/env bash
set -e

# Copy starter content into user home (safe for ephemeral)
if [ -d /opt/jupyter-starter ]; then
  mkdir -p "$HOME/jupyter-starter"
  cp -a /opt/jupyter-starter/. "$HOME/jupyter-starter/" 2>/dev/null || true
fi

# Continue with the standard docker-stacks entrypoint
exec /usr/local/bin/start-notebook.py "$@"
