#!/bin/bash

flutter config --no-analytics
flutter pub global activate melos
dart pub global run flutter_plugin_tools format
echo "$HOME/.pub-cache/bin/" >> "$GITHUB_PATH"
echo "$GITHUB_WORKSPACE/_flutter/.pub-cache/bin" >> "$GITHUB_PATH"
echo "$GITHUB_WORKSPACE/_flutter/bin/cache/dart-sdk/bin" >> "$GITHUB_PATH"