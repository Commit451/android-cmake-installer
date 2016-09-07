#!/bin/sh
# install CMake for Android builds. Assumes that you have ANDROID_HOME set properly
PACKAGE_XML_URL="https://github.com/Commit451/android-cmake-installer/releases/download/1.0.0/package.xml"
VERSION_MAJOR="3"
VERSION_MINOR="6"
VERSION_MICRO="3155560"
VERSION=${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_MICRO}
# can also be darwin or windows (but not really cause .sh)
PLATFORM="linux"
# A POSIX variable
# Reset in case getopts has been used previously in the shell.
OPTIND=1

# Initialize our own variables:
DEBUG=false

# : next to each one that takes variables
while getopts ":dp:v:" opt; do
  case $opt in
    d)
      DEBUG=true >&2
      ;;
    p)
      PLATFORM=$OPTARG >&2
      if [[ "$PLATFORM" != "linux" && "$PLATFORM" != "darwin" ]] ; then
        echo "Invalid platform: $PLATFORM"
        echo "Options are \"darwin\" (mac) or \"linux\""
        exit
      fi
      ;;
    v)
      VERSION=$OPTARG >&2
      versionIn=(${VERSION//./ })
      arrayLength=${#versionIn[@]}
      if [ "$arrayLength" != 3 ] ; then
          echo 'Incorrect version. Your version should be formatted like 3.6.1234'
          exit
      fi
      VERSION_MAJOR=${versionIn[0]}
      VERSION_MINOR=${versionIn[1]}
      VERSION_MICRO=${versionIn[2]}
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift
if [ "$DEBUG" = true ] ; then
    echo 'Debug enabled. Prepare for lots of printing'
    echo "Platform: $PLATFORM"
    echo "Version: $VERSION"
    echo "Version Major: $VERSION_MAJOR"
    echo "Version Minor: $VERSION_MINOR"
    echo "Version Micro: $VERSION_MICRO"
fi

NAME="cmake-${VERSION}-${PLATFORM}-x86_64"
wget https://dl.google.com/android/repository/${NAME}.zip

if [ ! -f ${NAME}.zip ]; then
    echo "CMake version not found on server"
    exit
fi

DIRECTORY=${ANDROID_HOME}/cmake/${VERSION}
mkdir -p ${DIRECTORY}
unzip ${NAME}.zip -d ${DIRECTORY}
rm ${NAME}.zip
# Now, in order to trick gradle into believing that we have installed
# through the official means, we need to include a package.xml file
wget ${PACKAGE_XML_URL}
sed -i -- 's/CMAKE_VERSION_COMPLETE/'"$VERSION"'/g' package.xml
sed -i -- 's/CMAKE_VERSION_MAJOR/'"$VERSION_MAJOR"'/g' package.xml
sed -i -- 's/CMAKE_VERSION_MINOR/'"$VERSION_MINOR"'/g' package.xml
sed -i -- 's/CMAKE_VERSION_MICRO/'"$VERSION_MICRO"'/g' package.xml
mv package.xml ${DIRECTORY}
