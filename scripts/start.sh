#!/usr/bin/sh

# TODO: Arg for dev / prod

# Install deps
mix deps.get

# Run mix
mix run --no-halt
