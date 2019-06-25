#!/bin/bash

f=0
p=0

cat /dev/stdin | while read line ; do
    if [[ $line =~ ".git/" ]]; then
        continue
    elif [[ $line =~ "^README.md$" ]]; then
        continue
    fi
    if [[ ${line: -6} == ".patch" ]]; then
        ((p+=1))
        export PATCHES=p
        patchfile=$line
        filename=${patchfile//\.patch/}
        dstfilename=${filename//haven-patches/monero}
        #echo "Applying patch file $patchfile for target ${dstfilename} ...";
        patch -p0 $dstfilename < $patchfile
    else
        ((f+=1))
        export FILES=f
        dstfilename=${line//haven-patches/monero}
        echo "Copying file $line to ${dstfilename} ...";
        cp $line ${dstfilename}
    fi
done

#echo "Patched $PATCHES files, copied $f files."
