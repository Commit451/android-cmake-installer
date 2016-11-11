# android-cmake-installer

Install CMake with proper configuration for Android projects

[![Build Status](https://travis-ci.org/Commit451/android-cmake-installer.svg?branch=master)](https://travis-ci.org/Commit451/android-cmake-installer)

# Usage
To install the CMake ready for Android development:
```bash
wget https://github.com/Commit451/android-cmake-installer/releases/download/1.1.0/install-cmake.sh
chmod +x install-cmake.sh
./install-cmake.sh
```
This assumes that the `ANDROID_HOME` is set already in your path.

# Advanced Usage
If you need more advanced usage, command line arguments are available:
```bash
./install-cmake.sh
    -d # logs a bunch
    -p [platform] # either darwin (mac) or linux. Default is linux
    -v [version] # in the format like 3.6.3155560
```
# Example
This script is currently used in [PixelAdjuster](https://github.com/Commit451/PixelAdjuster) if you want to see a full setup. If you are using travis-ci to build, it ships with an older version of `libstdc++6` which does not work with Android CMake, so take a look at the `.travis-ci.yml` script to see the workaround.

# Official Support
If you run a CMake build on a CI server, you might see the message like:
```
Failed to find CMake.
  Install from Android Studio under File/Settings/Appearance & Behavior/System Settings/Android SDK/SDK Tools/CMake.
  Expected CMake executable at /usr/local/android-sdk/cmake/bin/cmake.
```
This library installs the Google official CMake binary, and also tricks Gradle into believing that you installed CMake the official way through the SDK Manager.

Hopefully Google will support installing CMake via command line in a more official way at some point. Star or follow [this issue](https://code.google.com/p/android/issues/detail?id=221907) if you want to show support for making this happen.

License
--------

    Copyright 2016 Commit 451

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
