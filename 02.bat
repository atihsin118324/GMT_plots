gmt set FORMAT_GEO_MAP ddd:mm:ssF
gmt set MAP_FRAME_WIDTH 0.1c
gmt set FONT_TITLE 40p,Helvecita-Bold
gmt set FONT_ANNOT_PRIMARY 16p
gmt set FONT_ANNOT_SECONDARY 10p

set topography=D:\NTU\GMT\Final_report\data\ETOPO1_Bed_g_gmt4.grd
set faults=D:\NTU\GMT\Final_report\data\faults.txt
set cpt=D:\NTU\GMT\Final_report\data\elevation.cpt
set gps=D:\NTU\GMT\Final_report\data\gps.txt

set range=7/18/36.5/47

REM data processing
gawk "NR>1 {print $4, $5, $9, $7, $5, $6, $8, $1}" %gps% > gps.tmp
gawk "{print $1, $2, sqrt($3^2+$4^2)}" gps.tmp > vect.tmp

REM make cpt for gps velo
gmt makecpt -Crainbow -T24/31/1 -Z > cpt.tmp
gmt makecpt -Cgray -T-6000/3000/250 -I > cpt_gray.tmp

gmt begin 02_gps jpg A+m0.5c
    gmt basemap -Jm10.0/.8i -R%range% -B1f0.5 -B+t"Velocity Field in the Italian Region "
	
	REM Plot Velocity gradientwith blockmean and surface
    gmt blockmean vect.tmp -R%range% -I0.01 -h1 > cgps_mean.tmp
    gmt surface cgps_mean.tmp -R%range% -T0.35 -I0.01 -Gcgps_mean.grd.tmp -V
    gmt grdimage cgps_mean.grd.tmp -I+a315+ne0.3 -Ccpt.tmp -V
	gmt colorbar -Ccpt.tmp -Dx4c/-2c+w10c/0.5c+h+e+jCM -Ba1f1 -By+l"mm/yr" -I -V
	
	gmt grdcut %topography% -Ggrd.tmp -R%range%
	rem gmt grdimage grd.tmp -I+a60+ne1.0 -C%cpt_gray.tmp% -t70 -V
	gmt coast -Df -W1.5p -Sfloralwhite -N1/1.5p,100 -Lg7.8/38+w100+f+lkm -V	
	
	REM Plot Velocity vector
	gmt velo gps.tmp -Se.06/0/0 -A0.15i+a30+e -W1.5p,Black -h1 -V
	
	echo 13 36.0 17,32 0 TL Data from Mantovani, Enzo, et al.  | gmt text -F+f+a+j -N -Dj0/0.3
	echo 13 35.7 17,32 0 TL Present velocity field in the Italian region  | gmt text -F+f+a+j -N -Dj0/0.3
	echo 13 35.4 17,32 0 TL by GPS data: geodynamic/tectonic implications. | gmt text -F+f+a+j -N -Dj0/0.3
	echo 13 35.1 17,32 0 TL international Journal of Geosciences 6.12 (2015) | gmt text -F+f+a+j -N -Dj0/0.3
  
gmt end show
rem del *.tmp 
pause
