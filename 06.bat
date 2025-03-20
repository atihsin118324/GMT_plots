@ECHO OFF
gmt gmtset MAP_ORIGIN_X 1.9i MAP_ORIGIN_Y 1.8i
gmt gmtset PROJ_LENGTH_UNIT inch
gmt gmtset FORMAT_GEO_MAP ddd:mm:ssF
gmt gmtset MAP_FRAME_TYPE Plain

set range=5/19/36.5/48/-6000/4000
set topography=D:\NTU\GMT\Final_report\data\ETOPO1_Bed_g_gmt4.grd


gmt begin 06_3dmap jpg A+m0.5c
	gmt grdcut %topography% -Ggrd.tmp -R%range%
	gmt grdinfo grd.tmp > grd.info
	type grd.info
    gmt grd2cpt grd.tmp -Chaxby -Z 
    gmt grdview grd.tmp -Jm15/40/0.5i -Jz0.0001 -C -I+a30+ne0.8 -R%range% -p160/40/0 -Qi -N-10001+g200 -Bx1 -By1 -Bz2500+l"m" -BSEwnz -Y1.5 -X0.5
    gmt coast -Jz -p160/40/0 -Df -W1p -N1/1.5p,100 -A1000 -V
	gmt colorbar -Dx3c/-1.5c+w15c/0.25c+h+e -I -Bx1000 -By+lm -V  
	
    echo 17 47.00 24,32 -12 TC 3D Relief of Italy Area | gmt text -F+f+a+j -N  
    echo 12.2 45.00 13,22,255 0 CB Southern Alps > whiteword.txt
    echo 12.0 44.00 15,22,255 -15 CB N.Apennines >> whiteword.txt
    echo 16.5 40.30 15,22,255 -50 CB S.Apennines >> whiteword.txt
	echo 14.65 42.20 15,22,255 -50 CB C.Apennines >> whiteword.txt
    echo 13 40.10 10,22,255 0 CB Tyrrhenian Sea >> whiteword.txt
	echo 17.5 42.00 10,22,50 -50 CB Adriatic Sea >> whiteword.txt
    echo 14.3 38.9 13,22,255 0 CB Sicily >> whiteword.txt
	echo 17.5 38.4 13,22,255 20 CB Calabrian Arc >> whiteword.txt
    gmt text whiteword.txt -Jz -F+f+a+j -N 
	
gmt end show

del *.tmp *.info whiteword.txt
del 
pause
