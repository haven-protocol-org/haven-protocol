#!/bin/bash

# Check for presence of monero code
if [ ! -d "ledger-app-monero" ] || [ ! -e "ledger-app-monero/.git" ]; then

    # Check out monero code
    echo "Monero Ledger app tree not found in $PWD - cloning from github..."
    git clone --recursive https://github.com/LedgerHQ/ledger-app-monero
fi

# Reset monero ledger app code to HEAD
pushd ledger-app-monero > /dev/null 2>&1
git checkout -b master
git reset HEAD --hard
popd > /dev/null 2>&1

# Apply patches / whole files to the monero codebase
echo "Applying patches to Monero Ledger app codebase:"
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
        dstfilename="../ledger-app-monero/$filename"
        #echo "Applying patch file $patchfile for target $dstfilename";
        patch -p0 $dstfilename < $patchfile
    else
        dstfilename="../ledger-app-monero/$line"
        echo "Copying file $line to $dstfilename";
        cp $line $dstfilename
    fi
done
popd > /dev/null 2>&1

echo "Building ledger app..."
pushd ledger-app-monero > /dev/null 2>&1
make load
popd > /dev/null 2>&1
echo "Done."
