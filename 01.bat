gmt set FORMAT_GEO_MAP ddd:mm:ssF
gmt set MAP_FRAME_WIDTH 0.1c
gmt set FONT_TITLE 40p,Helvecita-Bold
gmt set FONT_ANNOT_PRIMARY 16p
gmt set FONT_ANNOT_SECONDARY 10p

set topography=D:\NTU\GMT\Final_report\data\ETOPO1_Bed_g_gmt4.grd
set faults=D:\NTU\GMT\Final_report\data\faults.txt
set cpt=D:\NTU\GMT\Final_report\cpt\elevation.cpt

set range=7/18/36.5/47


gmt begin 01_italy jpg A+m0.5c
    gmt basemap -Jm10.0/.8i -R%range% -B1f0.5 -B+t"Italy"
	gmt grdcut %topography% -Ggrd.tmp -R%range%
    gmt grdimage grd.tmp -C%cpt% -I+a130+ne0.4 -V
    gmt coast -Df -W1p,0 -N1/1.5p,100 -Lg7.8/38+w100+f+lkm -A1000 -V	
    gmt colorbar -C%cpt% -Dx4i/-1i+w6i/0.2i+h+e+jCM -Bf500a2000+l"Relief of Italy (ETOPO)" ^
    -By+lmeter -I -V
	
	gmt plot %faults% -W2p,red,2_1_2_1:0p -l"active faults" -V
	
    echo 10.2 45.30 30,22,255 0 CB Southern Alps > whiteword.txt
    echo 10.1 44.20 30,22,255 -18 CB N.Apennines >> whiteword.txt
    echo 14.9 40.50 30,22,255 -45 CB S.Apennines >> whiteword.txt
	echo 12.5 42.30 30,22,255 -49 CB C.Apennines >> whiteword.txt
    echo 11.8 39.80 30,22,255 0 CB Tyrrhenian Sea >> whiteword.txt
	echo 15.5 42.60 30,22,50 -42 CB Adriatic Sea >> whiteword.txt
    echo 14 37.5 30,22,255 0 CB Sicily >> whiteword.txt
	echo 16.55 37.6 25,22,255 50 CB Calabrian Arc >> whiteword.txt
    gmt text whiteword.txt -F+f+a+j -N
	
	REM city
	echo 12.794 41.928 17,32 0 BR Roma | gmt text -F+f+a+j -N -Dj0/0.3
	echo 12.794 41.928 | gmt plot -Sr.2 -G0 -W0.1
	echo 14.245 40.97 17,32 0 BR Naploi | gmt text -F+f+a+j -N -Dj0/0.3
	echo 14.245 40.97 | gmt plot -Sr.2 -G0 -W0.1 	
	echo 11.218 43.708 17,32 0 BR Firenze | gmt text -F+f+a+j -N -Dj0/0.3
	echo 11.218 43.708 | gmt plot -Sr.2 -G0 -W0.1 	
	echo 11.74 44.86 17,32 0 BR Bologna | gmt text -F+f+a+j -N -Dj0/0.3
	echo 11.74 44.86 | gmt plot -Sr.2 -G0 -W0.1
	echo 12.41 45.66 17,32 0 BR Venezia | gmt text -F+f+a+j -N -Dj0/0.3
	echo 12.41 45.66 | gmt plot -Sr.2 -G0 -W0.1
	echo 9.39 45.57 17,32 0 BR Milano | gmt text -F+f+a+j -N -Dj0/0.3
	echo 9.39 45.57 | gmt plot -Sr.2 -G0 -W0.1
	echo 16.87 41.155 17,32 0 BR Bari | gmt text -F+f+a+j -N -Dj0/0.3
	echo 16.87 41.155 | gmt plot -Sr.2 -G0 -W0.1
	echo 8.94 44.69 17,32 0 BR Genova | gmt text -F+f+a+j -N -Dj0/0.3
	echo 8.94 44.69 | gmt plot -Sr.2 -G0 -W0.1
	echo 7.74 45.52 17,32 0 BR Torino | gmt text -F+f+a+j -N -Dj0/0.3
	echo 7.74 45.52 | gmt plot -Sr.2 -G0 -W0.1
	echo 13.531 43.617 17,32 0 BR Ancona | gmt text -F+f+a+j -N -Dj0/0.3
	echo 13.531 43.617 | gmt plot -Sr.2 -G0 -W0.1
	echo 12.396 43.11 17,32 0 BR Perugia | gmt text -F+f+a+j -N -Dj0/0.3
	echo 12.396 43.11 | gmt plot -Sr.2 -G0 -W0.1
	echo 14.216 42.459 17,32 0 BR Pescara | gmt text -F+f+a+j -N -Dj0/0.3
	echo 14.216 42.459 | gmt plot -Sr.2 -G0 -W0.1
	
gmt end show
del *.tmp whiteword.txt
pause
