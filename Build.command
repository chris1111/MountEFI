
# Mount_EFI
# (c) Copyright 2022 chris1111 
# This will create a Apple Bundle Mount_EFI
# Dependencies: Xcode
PARENTDIR=$(dirname "$0")
cd "$PARENTDIR"

echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "
echo "Build Mount_EFI"
echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "

xcodebuild -project ./Mount-EFI.xcodeproj -alltargets -configuration Release

