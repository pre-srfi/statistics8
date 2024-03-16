#!/bin/sh
set -eu
cd "$(dirname "$0")"
echo "Entering directory '$PWD'"
cc="-D ANSIPROT"
for c in airy.c const.c expx2.c gamma.c igam.c igami.c incbet.c incbi.c \
    isnan.c jv.c mtherr.c ndtr.c ndtri.c polevl.c; do
    cc="$cc ../cephes/$c"
done
set -x
gsc-script -cc-options "$cc" statistics.sld
