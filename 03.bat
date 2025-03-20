REM gmt set FORMAT_GEO_MAP ddd:mm:ssF
REM gmt set MAP_FRAME_WIDTH 0.1c
REM gmt set FONT_ANNOT_PRIMARY 10p
REM gmt set FONT_ANNOT_SECONDARY 8p

set in=italy_los.tif
set out1=italy_los.nc
set cos=cos.grd

REM gmt grdconvert %in%=gd:GTiff -G%out1%=nf -V
set range=8/17.2/39/46
set range_inset=12.7/16/40.7/42.6

gmt begin 03_LOS_displacement jpg A+m0.5c
    gmt basemap -Jm10.0/3i -R%range2% -B1f0.5
    gmt grd2cpt %cos% -Z -Crainbow -V
    gmt grdimage %cos% -I+a130+ne0.8 -V
    gmt coast -Df -W1p,0 -S132/193/255 -N2/1p,255 -V
	gmt plot faults.txt -W3p,pink
    gmt colorbar -Dx3.0i/-0.4i+w4.5i/0.1i+h+e+jCM -Bf1000a500+l"LOS Displacement of Central Italy" ^
    -By+lmeter --FONT_LABEL=12p --FONT_ANNOT_PRIMARY=6p -I -V 
	
	gmt inset begin -DjTR+w3c/3.6c
	    gmt coast -JM? -R%range_inset% -W0.2p,0 -Ggray -Swhite -N1/0.2p,255 -A10000 -Btblr --MAP_FRAME_TYPE=plain -V
		echo 12.5 40 15 44 | gmt plot -Sr+s -W1p,blue
	gmt inset end
	
gmt end show
del *.conf
pause

