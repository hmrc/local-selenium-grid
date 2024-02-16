#!/bin/bash
set -euxo pipefail

# currently hmrc/docker-selenium-grid is pinned to https://github.com/SeleniumHQ/docker-selenium/releases/tag/4.16.1-20231219
# you can find the browser versions that are provided by default in that release in the github release notes at the above link

selenium_dir="$(dirname $0)"
selenium_log="$selenium_dir/selenium-server.log"
selenium_jar="$selenium_dir/selenium-server-4.17.0.jar"
selenium_jar_url="https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.17.0/selenium-server-4.17.0.jar"

if ! [ -f "$selenium_jar" ]; then
  curl --location --fail --output "$selenium_jar" "$selenium_jar_url"
fi

rm -f "$selenium_log"

java -jar "$selenium_jar" \
  standalone \
  --log    "$selenium_log" \
  --config "$selenium_dir/browser-versions.toml"
