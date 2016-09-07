# install CMake for Android builds. Assumes that you have ANDROID_HOME set properly
VERSION_MAJOR="3"
VERSION_MINOR="6"
VERSION_MICRO="3155560"
VERSION=${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_MICRO}
# can also be darwin or windows
PLATFORM="linux"
NAME="cmake-${VERSION}-${PLATFORM}-x86_64"
PACKAGE_XML_URL="https://dl.dropboxusercontent.com/u/18415572/package.xml"
wget https://dl.google.com/android/repository/${NAME}.zip
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
