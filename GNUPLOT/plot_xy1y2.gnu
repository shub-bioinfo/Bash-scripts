#To Generate the plot for the rescaled time vs metadynamics time from Infrequent MTD run.
for i in 12 ;do 
#for i in 01 02 03 04 05 06 07 08 09 `seq 10 24`;do 

cd Infreq_MTD_$i 
echo $i

var='$1'
vas='$3'
gnuplot <<EOF

set xrange [0:10]
#Offset to set the distance in x,y,z direction 
set ylabel "Rescaled Time (ns)" tc rgb "blue" font 'Arial, 32' offset 2,0,0 
set xlabel "Metadynamics Time (ns)"  font 'Arial, 32' offset 0,1,0
set y2label " Phi "  tc rgb "red" font 'Arial, 32' offset -2,0,0

#Graph settings
set grid xtics ytics noy2tics lw 2
set border lw 2
set title "Run $i  " font 'Arial, 32'
#set title "Run $i T_M_T_D= 8 ns " font 'Arial, 32'

#Tics label size
set tics font 'Arial, 28' 
#set ytics nomirror to have different in y2 axis. For y1 is default use y commands.
set xtics offset 0,0.5,0
set ytics nomirror
set y2range [-3.2:3.2]
set ytics tc rgb "blue" offset 0.5,0,0
set y2tics -3.0,1,3.0 tc rgb "red" offset -0.8,0,0

#To adjust the fontsize of legend and the spacing of the legends
#set key font 'Arial, 24'
#set key spacing 0.8
#5cc863" 
plot "COLVAR" us ($var/1000):2  axes x1y2 w dots lt  rgb "blue" notitle, "mtd_scaled_time.dat" us ($var/1000):($vas/1000) w l lw 3 lt rgb "red" notitle,


set terminal  pngcairo size 1024,720 enhanced color font 'Arial, 30'
set output "plot_mtd_rescaled_phi$i.png"
repl

EOF
mv plot_mtd_rescaled_phi$i.png ../

cd ..
done
