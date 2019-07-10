#!/bin/bash

# Check for presence of monero code
if [ ! -d "monero" ] || [ ! -e "monero/.git" ]; then

    # Check out monero code
    echo "Monero tree not found in $PWD - cloning from github..."
    git clone --recursive https://github.com/monero-project/monero
fi

# Reset monero code to HEAD
pushd monero
git checkout -b master
git reset HEAD --hard
popd

# Apply patches / whole files to the monero codebase
find src -type f | while read line ; do
    if [[ $line =~ ".git/" ]]; then
        continue
    elif [[ $line =~ "^README.md$" ]]; then
        continue
    fi
    if [[ ${line: -6} == ".patch" ]]; then
        patchfile=$line
        filename=${patchfile//\.patch/}
        dstfilename="monero/$filename"
        #echo "Applying patch file $patchfile for target $dstfilename ...";
        patch -p0 $dstfilename < $patchfile
    else
        dstfilename="monero/$line"
        echo "Copying file $line to $dstfilename ...";
        cp $line $dstfilename
    fi
done
