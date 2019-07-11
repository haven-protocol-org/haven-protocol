haven-patches
=============

This repository is a test-bed to attempt to perform a full rebase of the latest monero code
(currently v0.14.1.0) using a series of patch files.
 
To build haven, simply run the following command(s):
 
<pre>$ ./build-haven.sh <i>buildtype</i></pre>  
 
where _&lt;buildtype&gt;_ is the standard **make** option (e.g. "release")
 
To build the blockchain explorer, you need to build haven first (see above). Once that is
done, you should run the following commands:
 
<pre>
$ cd haven-blockchain-explorer<br/>
$ ./build-blockchain-explorer.sh
</pre>
 
Parallel compilation
--------------------
If you wish to use multiple CPU cores to compile quicker (i.e. the "-jN" option), simply
set the appropriate flags in the MAKEFLAGS environment variable before running the
build scripts, e.g.
 
<pre>
$ export MAKEFLAGS='-j8'<br/>
$ ./build-haven.sh <i>buildtype</i>
</pre>
 
or more simply

<pre>
$ MAKEFLAGS='-j8' ./build-haven.sh <i>buildtype</i>
</pre>