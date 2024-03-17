#!/bin/sh
set -eu
cd "$(dirname "$0")"
echo "Entering directory '$PWD'"
set -x
gsi-script ../gambit/ generate-plots.scm
gnuplot chi-squared-cdf-plot
gnuplot normal-cdf-plot
gnuplot student-cdf-plot
