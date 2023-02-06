#!/usr/bin/env bash
# fail if any commands fails
set -e
# debug log
# set -x

# Etape 1 : ajoute ANDROID_SDK
echo sdk.dir=/usr/local/lib/android/sdk >> src/ApplicationCompte/local.properties
exit 0

#JAVA_HOME: /opt/hostedtoolcache/Java_Zulu_jdk/11.0.18-10/x64
MY_ANDROID_HOME=/usr/local/lib/android/sdk
#MY_ANDROID_SDK_ROOT: /usr/local/lib/android/sdk
# VARIABLES
API_LEVEL=29

# Etape 2 : démarre l'émulateur
EMULATOR_COUNT=$(${MY_ANDROID_HOME}/tools/emulator -list-avds | wc -l)
if [[ ${EMULATOR_COUNT} -gt 0 ]]
then
    echo "Emulator already available"
else
    # Install Emulator
    sudo ${MY_ANDROID_HOME}/tools/bin/sdkmanager --update
    ${MY_ANDROID_HOME}/tools/bin/sdkmanager --install "emulator"
    ${MY_ANDROID_HOME}/tools/bin/sdkmanager --install "system-images;android-${API_LEVEL};google_apis;x86"
    echo "no" | ${MY_ANDROID_HOME}/tools/bin/avdmanager --verbose create avd --force --name "pixel" --device "pixel" --package "system-images;android-${API_LEVEL};google_apis;x86" --tag "google_apis" --abi "x86"
    ${MY_ANDROID_HOME}/emulator/emulator @pixel -no-window -no-boot-anim -netdelay none -no-snapshot -wipe-data -verbose -show-kernel -no-audio -gpu swiftshader_indirect -no-snapshot &> /tmp/log.txt &
    adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 5; done; input keyevent 82'
    adb shell settings put global window_animation_scale 0.0
    adb shell settings put global transition_animation_scale 0.0
    adb shell settings put global animator_duration_scale 0.0
    # Add ANDROID_SDK_ROOT
    echo sdk.dir=/usr/local/lib/android/sdk >> src/ApplicationCompte/local.properties
fi


