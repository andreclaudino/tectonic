#! /bin/bash
# Copyright 2016 The Tectonic Project
# Licensed under the MIT License.

cd $(dirname $0)

# Throw away stderr since it has a bunch of diagnostic output from our I/O backend.
../../BUILD/tectonic-compat -fmt=etrip -no-pdf -output-comment=etrip etrip >etrip.fot 2>/dev/null
anybad=false

for f in etrip.log etrip.fot etrip.xdv etrip.out ; do
    if ! cmp $f reference-$f ; then
	echo >&2 "etrip failed: file $f differs"
	anybad=true
    fi
done

$anybad && exit 1

rm -f etrip.fot etrip.log etrip.xdv etrip.out
