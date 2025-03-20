gmt set FORMAT_GEO_MAP ddd:mm:ssF
gmt set MAP_FRAME_WIDTH 0.1c
gmt set FONT_TITLE 12p,Helvecita-Bold
gmt set FONT_ANNOT_PRIMARY 10p
gmt set FONT_ANNOT_SECONDARY 8p

set topography=D:\NTU\GMT\Final_report\data\topography.grd
set cpt=D:\NTU\GMT\Final_report\cpt\fpcolor.cpt
set eq=D:\NTU\GMT\Final_report\data\earthquake1985-2023_all.txt
set mfile=D:\NTU\GMT\Final_report\data\meca3.txt
set range=12/14.4/42.2/43.6
set range_inset=7/18/36.5/47

gmt grdcut %topography% -Ggrad.tmp -R%range%	
gmt project -C12.8/43.2 -E13.5/42 -G.5 -Q > trackA.tmp
gmt grdtrack trackA.tmp -Ggrad.tmp | gawk "{ print $3, $4 }" > trackA.xyp.tmp
gmt makecpt -Cgray -T0/4000/500 -I -N > gray_cpt.tmp -V

gmt begin 09_profile jpg A+m0.5c
	gmt basemap -R%range% -Jm13.0/1.8i -Bxa0.5f0.5 -Bya0.5f0.5 -BWSen -V
	gmt grdimage grad.tmp -Cgray_cpt.tmp -I+a45+ne1.0 -V
	gmt coast -R%range% -Jm13.0/1.8i -W0.1p -S212/231/237 -Lg12.25/42.4+w20+f+lkm -V
	
	REM ====== Sort by magnitude ===========
    gawk -F"|" "NR>1 { if ($11 < 2)  print $4, $3, $5}" %eq% | gmt plot -C%cpt% -Sc.01 -V
    gawk -F"|" "NR>1 { if ($11 >= 2 && $11 < 3) print $4, $3, $5}" %eq% | gmt plot -C%cpt% -Sc.06 -V
    gawk -F"|" "NR>1 { if ($11 >= 3 && $11 < 4) print $4, $3, $5}" %eq% | gmt plot -C%cpt% -Sc.08 -V
    gawk -F"|" "NR>1 { if ($11 >= 4 && $11 < 5) print $4, $3, $5}" %eq% | gmt plot -C%cpt% -Sc.1 -V
    gawk -F"|" "NR>1 { if ($11 >= 5 && $11 < 6) print $4, $3, $5}" %eq% | gmt plot -C%cpt% -Sc.12 -V
    gawk -F"|" "NR>1 { if ($11 >= 6 && $11 < 7) print $4, $3, $5}" %eq% | gmt plot -C%cpt% -Sc.14 -V
	gmt colorbar -C%cpt% -Dx-0.2/-0.5+w1.5/0.05+h -Bx -By+l"km" -I -V -Y0.1
	
	REM ======= Plot Scale Points ===================
    echo 13.30 41.9 | gmt plot -Sc.01 -W1 -N -V
    echo 13.50 41.9 | gmt plot -Sc.06 -W1 -N -V
    echo 13.70 41.9 | gmt plot -Sc.08 -W1 -N -V
    echo 13.90 41.9 | gmt plot -Sc.1 -W1 -N -V
    echo 14.10 41.9 | gmt plot -Sc.12 -W1 -N -V
    echo 14.30 41.9 | gmt plot -Sc.14 -W1 -N -V
	REM ======= Plot Scale Text ====================
    echo 13.20 41.9 12,1,0 MC M@-L@- | gmt text -F+f+j -C0.01/0.01 -N -V
    echo 13.40 41.9 8,1 MC 2 | gmt text -F+f+j -Gyellow -N -V
    echo 13.60 41.9 8,1 MC 3 | gmt text -F+f+j -Gyellow -N -V
    echo 13.80 41.9 8,1 MC 4 | gmt text -F+f+j -Gyellow -N -V
    echo 14.00 41.9 8,1 MC 5 | gmt text -F+f+j -Gyellow -N -V
    echo 14.20 41.9 8,1 MC 6 | gmt text -F+f+j -Gyellow -N -V
    echo 14.40 41.9 8,1 MC 7 | gmt text -F+f+j -Gyellow -N -V
	
	echo 12.85 43.25 12,1 ML A | gmt text -F+f+j -N -V
    echo 13.55 42.2 12,1 BL A'| gmt text -F+f+j -N -V
	
	gmt meca %mfile% -Sm0.4c+f0 -Gred -A -L -h12 -V
	gmt plot trackA.tmp -W2p,0 -V
	
	REM inset
	gmt inset begin -DjTR+w2c/2.4c+o0/0.2c
	    gmt coast -JM? -R%range_inset% -W0.2p,0 -Ggray -Swhite -N1/0.2p,255 -A10000 -Btblr --MAP_FRAME_TYPE=plain -V
		echo 12 42.2 14.4 43.6 | gmt plot -Sr+s -W1p,blue
	gmt inset end
	
	REM subplot	
    gmt plot trackA.xyp.tmp -R0/100/0/3000 -JX2.5i/0.6i -G127.5 -W1p -L+yb -Bxa20f10+ukm -Bya1000f500+l"Elev (m)" -BWNbr+t"Profile AA'" -X6i -Y3i -V
	echo -15 3700 14 LB N | gmt text -F+f+j -N -V
	echo 115  3700 14 LB S | gmt text -F+f+j -N -V
	gawk -F"|" "NR>1 {print $4, $3, -1*$5, $11}" %eq% | gmt coupe -JX2.5i/1i -R0/100/-30/0 -Bxa20f10+l"Distance (km)" ^
	-Bya10f5+l"Depth (km)" -BWStr -W0.5p -Fsc0.04c/0 -Aa12.8/43.2/13.5/42/90/30/0/30 -Y-1i -V
	
	gmt plot trackA.xyp.tmp -R0/100/0/3000 -JX2.5i/0.6i -G127.5 -W1p -L+yb -Bxa20f10+ukm -Bya1000f500+l"Elev (m)" -BWNbr+t"Profile AA'" -Y-1.5i -V
	echo -15 3700 14 LB N | gmt text -F+f+j -N -V
	echo 115 3700 14 LB S | gmt text -F+f+j -N -V
	gmt coupe %mfile% -R0/100/-30/0 -Sm0.3c+f0 -Aa12.8/43.2/13.5/42+d90+w30+z0/30+r -h12 -Gred -JX2.5/-1 -Y-1i ^
	-Bxa20f10+l"Distance (km)" -Bya10f5+l"Depth (km)" -BWSe -V 
	


	
gmt end show
del *.tmp
pause