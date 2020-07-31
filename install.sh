#!/usr/bin/env bash

function echoheader() {
  echo -e "\e[35m$1\e[39m\n"
}

function echotext() {
  echo -e "\e[36m$1 ...\e[39m"
}

function echosuccess() {
  echo -e "\e[32m$1 ✓\e[39m\n"
}

clear

echoheader "Install android virtual machine"

export ANDROID_SDK_ROOT=/usr/lib/android-sdk

echotext "Create android home directory"
sudo mkdir -p /usr/lib/android-sdk/cmdline-tools
echosuccess "Create android home directory"

echotext "Install openjdk"
sudo apt-get install openjdk-8-jdk
echosuccess "Install openjdk"

echotext "Install android sdk"
sudo apt update && sudo apt install android-sdk
echosuccess "Install android sdk"

echotext "Download android command line tools"
sudo rm -rf ./commandlinetools*
sudo wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip
sudo unzip commandlinetools-linux-6609375_latest.zip -d /usr/lib/android-sdk/cmdline-tools
echosuccess "Download android command line tools"

echotext "Set path to include android"
export PATH=${PATH}:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/build-tools/25.0.2/
source /etc/profile
echosuccess "Set path to include android"

echotext "Sort permissions"
sudo chown $USER $ANDROID_SDK_ROOT
echosuccess "Sort permissions"

echotext "Create AVD (android virtual device)"
$ANDROID_SDK_ROOT/cmdline-tools/tools/bin/sdkmanager --install "system-images;android-27;google_apis;x86"
$ANDROID_SDK_ROOT/cmdline-tools/tools/bin/avdmanager create avd -n myfirstavd -k "system-images;android-27;google_apis;x86"
echosuccess "Create AVD (android virtual device)"

echotext "Run android emulator"
$ANDROID_SDK_ROOT/emulator/emulator -avd myfirstavd
echosuccess "Run android emulator"
