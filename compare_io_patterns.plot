#!/bin/bash

# usage
usage() { echo  "Usage: $0
         -n : test name
         -d : directory of test results (csv files)" 1>&2; exit 1; }

# process the arguments
while getopts ":n:d:" g; do
    case "${g}" in
    n) name=${OPTARG};;
    d) dir=${OPTARG};;
    *) usage;;
    esac
done
shift $((OPTIND-1))

secF=4

avgipsF=5
avgltnF=6
avgbndF=7

pref=${dir}/${name}

csv_h1=${pref}_hammer1
csv_h2=${pref}_hammer2
csv_h3=${pref}_hammer3
csv_s1=${pref}_seq1
csv_s2=${pref}_seq2
csv_s3=${pref}_seq3
csv_r1=${pref}_rand1
csv_r2=${pref}_rand2
csv_r3=${pref}_rand3

target=graphs/${name}

gnuplot <<-EOF
set datafile separator ","
set xlabel "time (seconds)"
set ylabel "IOPS"
set terminal png size 1920,1080
set output "${target}_iops.png"
set title "IOPS - $name"
set autoscale
#set xrange [0:50]

plot "$csv_h1" using (column($secF)):(column($avgipsF)) with lines lc rgb "olive" title "Hammer1", \
     "$csv_s1" using (column($secF)):(column($avgipsF)) with lines lc rgb "royalblue" title "Sequencial1", \
     "$csv_r1" using (column($secF)):(column($avgipsF)) with lines lc rgb "seagreen" title "Random1", \
     "$csv_r2" using (column($secF)):(column($avgipsF)) with lines lc rgb "green" title "Random2", \
     "$csv_h2" using (column($secF)):(column($avgipsF)) with lines lc rgb "olivedrab" title "Hammer2", \
     "$csv_s2" using (column($secF)):(column($avgipsF)) with lines lc rgb "navyblue" title "Sequencial2", \
     "$csv_s3" using (column($secF)):(column($avgipsF)) with lines lc rgb "steelblue" title "Sequencial3", \
     "$csv_r3" using (column($secF)):(column($avgipsF)) with lines lc rgb "chartreuse" title "Random3", \
     "$csv_h3" using (column($secF)):(column($avgipsF)) with lines lc rgb "goldenrod" title "Hammer3"
EOF

echo "$csv -> ${target}_iops.png"

gnuplot <<-EOF
set datafile separator ","
set xlabel "time (seconds)"
set ylabel "LATENCY (usec)"
set terminal png size 1920,1080
set output "${target}_latency.png"
set title "Latency - $name"
set autoscale
#set xrange [0:50]


plot "$csv_h1" using (column($secF)):(column($avgltnF)) with lines lc rgb "olive" title "Hammer1", \
     "$csv_s1" using (column($secF)):(column($avgltnF)) with lines lc rgb "royalblue" title "Sequencial1", \
     "$csv_r1" using (column($secF)):(column($avgltnF)) with lines lc rgb "seagreen" title "Random1", \
     "$csv_r2" using (column($secF)):(column($avgltnF)) with lines lc rgb "green" title "Random2", \
     "$csv_h2" using (column($secF)):(column($avgltnF)) with lines lc rgb "olivedrab" title "Hammer2", \
     "$csv_s2" using (column($secF)):(column($avgltnF)) with lines lc rgb "navyblue" title "Sequencial2", \
     "$csv_s3" using (column($secF)):(column($avgltnF)) with lines lc rgb "steelblue" title "Sequencial3", \
     "$csv_r3" using (column($secF)):(column($avgltnF)) with lines lc rgb "chartreuse" title "Random3", \
     "$csv_h3" using (column($secF)):(column($avgltnF)) with lines lc rgb "goldenrod" title "Hammer3"
EOF

echo "$csv -> ${target}_latency.png"

gnuplot <<-EOF
set datafile separator ","
set xlabel "time (seconds)"
set ylabel "BANDWIDTH (KB/s)"
set terminal png size 1920,1080
set output "${target}_bandwidth.png"
set title "Bandwidth - $name"
set autoscale
#set xrange [0:50]

plot "$csv_h1" using (column($secF)):(column($avgbndF)) with lines lc rgb "olive" title "Hammer1", \
     "$csv_s1" using (column($secF)):(column($avgbndF)) with lines lc rgb "royalblue" title "Sequencial1", \
     "$csv_r1" using (column($secF)):(column($avgbndF)) with lines lc rgb "seagreen" title "Random1", \
     "$csv_r2" using (column($secF)):(column($avgbndF)) with lines lc rgb "green" title "Random2", \
     "$csv_h2" using (column($secF)):(column($avgbndF)) with lines lc rgb "olivedrab" title "Hammer2", \
     "$csv_s2" using (column($secF)):(column($avgbndF)) with lines lc rgb "navyblue" title "Sequencial2", \
     "$csv_s3" using (column($secF)):(column($avgbndF)) with lines lc rgb "steelblue" title "Sequencial3", \
     "$csv_r3" using (column($secF)):(column($avgbndF)) with lines lc rgb "chartreuse" title "Random3", \
     "$csv_h3" using (column($secF)):(column($avgbndF)) with lines lc rgb "goldenrod" title "Hammer3"
EOF

echo "$csv -> ${target}_bandwidth.png"
