gmt set FORMAT_GEO_MAP ddd:mm:ssF
gmt set MAP_FRAME_WIDTH 0.1c
gmt set MAP_FRAME_TYPE = plain

set topography=D:\NTU\GMT\Final_report\data\ETOPO1_Bed_g_gmt4.grd
set data=D:\NTU\GMT\Final_report\data\earthquake1985-2023.txt
set cpt=D:\NTU\GMT\Final_report\data\elevation.cpt 

set range=8/17.2/39/46 

gmt makecpt -Chot -T3/6.6/0.5 -I > fd_hot.cpt -V

gmt begin 07_seismicity jpg A+m0.5c
	gmt grdcut %topography% -Ggrd.tmp -R%range%
    gmt basemap -Jm10.0/1i -R%range% -B1f0.5 -B+t"Seismicity 1985-2023/6/6 (data from INGV)"
	gmt grdimage grd.tmp -C%cpt% -I+a130+ne0.3 -V
	gmt coast -Df -W1p,0 -N1/1.2p,100 -A100 -V
	gmt colorbar -C%cpt% -Dx2c/-2.2c+w6c/0.5c+h -Bf500a2000 -By+l"Elevation(m)" -I -V

	gawk -F"|" "NR>1 {if ($11 >= 3 && $11 < 4) print $4, $3, $11}" %data% | gmt plot -Sc.3 -Cfd_hot.cpt -W0.01 -V 
	gawk -F"|" "NR>1 {if ($11 >= 4 && $11 < 5) print $4, $3, $11}" %data% | gmt plot -Sc.5 -Cfd_hot.cpt -W0.01 -V
	gawk -F"|" "NR>1 {if ($11 >= 5 && $11 < 6) print $4, $3, $11}" %data% | gmt plot -Sc.7 -Cfd_hot.cpt -W0.01 -V
	gawk -F"|" "NR>1 {if ($11 >= 5 && $11 < 6.5) print $4, $3, $11}" %data% | gmt plot -Sc.9 -Cfd_hot.cpt -W0.01 -V
	gawk -F"|" "NR>1 {if ($11 >= 6.5 ) print $4, $3, $11}" %data% | gmt plot -Sa1.2 -Cfd_hot.cpt -W0.01 -V
	gmt colorbar -Cfd_hot.cpt -Dx2c/-3.5c+w6c/0.5c+h -Ba1f0.5 -By+l"Magnitude" -V
	
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
	echo 13.531 43.617 17,32 0 BR Ancona | gmt text -F+f+a+j -N -Dj0/0.3
	echo 13.531 43.617 | gmt plot -Sr.2 -G0 -W0.1
	echo 12.396 43.11 17,32 0 BR Perugia | gmt text -F+f+a+j -N -Dj0/0.3
	echo 12.396 43.11 | gmt plot -Sr.2 -G0 -W0.1
	echo 14.216 42.459 17,32 0 BR Pescara | gmt text -F+f+a+j -N -Dj0/0.3
	echo 14.216 42.459 | gmt plot -Sr.2 -G0 -W0.1
	
	echo 12.6 38.2 | gmt plot -Sa1.2 -Gblack -W0.01 -V -N
	echo 13.2 38.2 17,1 0 ML M6.5 2016/10/30 -06:40:18 UTC | gmt text -F+f+a+j -N
	echo 13.2 37.9 17,1 0 ML Lat:42.84  Lon:13.11  Depth:10.0km | gmt text -F+f+a+j -N
	
gmt end show
del *.conf fd_hot.cpt
pause

