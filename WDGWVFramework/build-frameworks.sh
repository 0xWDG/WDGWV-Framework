#!/bin/sh

TARGET_NAME="WDGWVFramework-iOS"
FRAMEWORK_NAME="WDGWVFramework"
INSTALL_DIR="Frameworks/iOS"
FRAMEWORK="${INSTALL_DIR}/${FRAMEWORK_NAME}.framework"

if [ -d "${INSTALL_DIR}" ]
then
rm -rf "${INSTALL_DIR}"
fi

mkdir -p "${INSTALL_DIR}"

WRK_DIR="build"
DEVICE_DIR="${WRK_DIR}/Release-iphoneos/${FRAMEWORK_NAME}.framework"
SIMULATOR_DIR="${WRK_DIR}/Release-iphonesimulator/${FRAMEWORK_NAME}.framework"
OSX_DIR="${WRK_DIR}/Release/${FRAMEWORK_NAME}.framework"

echo "Building for iOS"
xcodebuild -configuration "Release" -target "WDGWVFramework-iOS" -sdk iphoneos SYMROOT=$(PWD)/${WRK_DIR} &> /dev/null #passing

echo "Building for iOS Simulator"
xcodebuild -configuration "Release" -target "WDGWVFramework-iOS" -sdk iphonesimulator SYMROOT=$(PWD)/${WRK_DIR} &> /dev/null #passing

lipo -create "${DEVICE_DIR}/${FRAMEWORK_NAME}" "${SIMULATOR_DIR}/${FRAMEWORK_NAME}" -output "${DEVICE_DIR}/${FRAMEWORK_NAME}"

echo "Building for Mac OS X"
xcodebuild -configuration "Release" -target "WDGWVFramework-OSX" -sdk macosx SYMROOT=$(PWD)/${WRK_DIR}
# lipo -create "${OSX_DIR}/${FRAMEWORK_NAME}" -output "${OSX_DIR}/${FRAMEWORK_NAME}"

# xcodebuild -configuration "Release" -target "${TARGET_NAME}" -sdk watchos SYMROOT=$(PWD)/${WRK_DIR}
# xcodebuild -configuration "Release" -target "${TARGET_NAME}" -sdk watchossimulator SYMROOT=$(PWD)/${WRK_DIR}
# xcodebuild -configuration "Release" -target "${TARGET_NAME}" -sdk tvos SYMROOT=$(PWD)/${WRK_DIR}
# xcodebuild -configuration "Release" -target "${TARGET_NAME}" -sdk tvossimulator SYMROOT=$(PWD)/${WRK_DIR}

exit

cp -R "${DEVICE_DIR}" "${INSTALL_DIR}/"

if [ -d "${SIMULATOR_DIR}/Modules/${FRAMEWORK_NAME}.swiftmodule/" ]; then
    cp -f -R "${SIMULATOR_DIR}/Modules/${FRAMEWORK_NAME}.swiftmodule/" "${FRAMEWORK}/Modules/${FRAMEWORK_NAME}.swiftmodule/" | echo
fi

rm -r "${WRK_DIR}"