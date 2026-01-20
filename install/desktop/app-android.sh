#!/bin/bash

cd /tmp

wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdlinetools.zip \
  && unzip cmdlinetools.zip -d /usr/lib/android-sdk/ \
  && cd /usr/lib/android-sdk/ \
  && mv cmdline-tools/ latest \
  && mkdir cmdline-tools \
  && mv latest/ cmdline-tools/ \
  && yes | ./cmdline-tools/latest/bin/sdkmanager --licenses \
  && ./cmdline-tools/latest/bin/sdkmanager "platforms;android-28" \
  && ./cmdline-tools/latest/bin/sdkmanager "build-tools;28.0.0" \
  && ./cmdline-tools/latest/bin/sdkmanager "platforms;android-35" \
  && ./cmdline-tools/latest/bin/sdkmanager "build-tools;35.0.0"

cd ~