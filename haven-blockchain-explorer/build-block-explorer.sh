#!/bin/bash

# Check for presence of monero code
if [ ! -d "onion-monero-blockchain-explorer" ] || [ ! -e "onion-monero-blockchain-explorer/.git" ]; then

    # Check out monero code
    echo "Onion Monero tree not found in $PWD - cloning from github..."
    git clone --recursive https://github.com/moneroexamples/onion-monero-blockchain-explorer
fi

# Reset onion monero code to HEAD
pushd onion-monero-blockchain-explorer > /dev/null 2>&1
git checkout -b master
git reset HEAD --hard
popd > /dev/null 2>&1

# Apply patches / whole files to the monero codebase
echo "Applying patches to Onion Monero codebase:"
pushd patches > /dev/null 2>&1
find * -type f | while read line ; do
    echo -n -e "\t"
    if [[ $line =~ ".git/" ]]; then
        continue
    elif [[ $line =~ "^README.md$" ]]; then
        continue
    fi
    if [[ ${line: -6} == ".patch" ]]; then
        patchfile=$line
        filename=${patchfile//\.patch/}
        dstfilename="../onion-monero-blockchain-explorer/$filename"
        #echo "Applying patch file $patchfile for target $dstfilename";
        patch -p0 $dstfilename < $patchfile
    else
        dstfilename="../onion-monero-blockchain-explorer/$line"
        echo "Copying file $line to $dstfilename";
        cp $line $dstfilename
    fi
done
popd > /dev/null 2>&1

echo "Creating build folder..."
mkdir onion-monero-blockchain-explorer/build
pushd onion-monero-blockchain-explorer/build > /dev/null 2>&1

echo "Monero dir is $PWD/../../../monero"
echo "Building blockchain explorer..."
cmake -DMONERO_DIR=$PWD/../../../monero ..
make

popd > /dev/null 2>&1
echo "Done."
