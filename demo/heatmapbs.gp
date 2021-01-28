reset
#set terminal epslatex color
set term postscript eps enhanced color font 'Helvetica,18'
set output "heatmapbs.eps"
#set output "heatmapbs.tex"
f="result.txt"

set xrange[-0.5:63]
#set yrange[-0.5:999.5]#1000
#set yrange[-0.5:200]
set cbrange[0:100]
set xlabel 'Cache Set'
set ylabel 'Sample'
set cblabel 'Time'

set mytics
set mxtics
set xtics out
set ytics out
set view map
splot f matrix with image t ''
set output
