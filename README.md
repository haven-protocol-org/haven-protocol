haven-protocol
==============

This repository is a full rebase of the latest monero code (currently release-v0.14) using a series of patch files.
 
To build haven, simply run the following command(s):
 
<pre>$ ./build-haven.sh <i>make_params</i></pre>  
 
where _&lt;make_params&gt;_ are the standard **make** options (e.g. "-j4 release")
 
To build the blockchain explorer, you need to build haven first (see above). Once that is
done, you should run the following commands:
 
<pre>
$ cd haven-blockchain-explorer<br/>
$ ./build-blockchain-explorer.sh
</pre>
