gmt set PROJ_LENGTH_UNIT=inch FORMAT_GEO_MAP=ddd:mm:ssG

set cpt=D:\NTU\GMT\Final_report\cpt\fpcolor.cpt
set data=D:\NTU\GMT\Final_report\data\earthquake1985-2023_all.txt
set grd=D:\NTU\GMT\Final_report\data\ETOPO1_Bed_g_gmt4.grd
set mfile=D:\NTU\GMT\Final_report\data\meca2.txt

set range=8/17.2/39/46

gmt makecpt -Cgray -T0/4000/500 -I -N > gray_cpt.tmp -V

gmt begin 08_meca jpg A+m0.5c
    gmt basemap -R%range% -Jm14.0/.8 -Bxa1f0.5 -Bya1f0.5 -BWSen -V
	gmt grdcut %grd% -Ggrd.tmp -R%range%	
	gmt grdimage grd.tmp -Cgray_cpt.tmp -I+a45+ne1.0 -V
    gmt coast -Df -W1 -S212/231/237 -V
	
	REM ======= Plot title string =======
	echo 12.35 46.5 25,2 MC Historical earthquakes (M@-w@- \076 6) and seismicity | gmt text -F+f+j -N -V
    
    REM ====== Sort by magnitude ===========
    gawk -F"|" "NR>1 { if ($11 < 2)  print $4, $3, $5}" %data% | gmt plot -C%cpt% -Sc.01 -V
    gawk -F"|" "NR>1 { if ($11 >= 2 && $11 < 3) print $4, $3, $5}" %data% | gmt plot -C%cpt% -Sc.06 -V
    gawk -F"|" "NR>1 { if ($11 >= 3 && $11 < 4) print $4, $3, $5}" %data% | gmt plot -C%cpt% -Sc.08 -V
    gawk -F"|" "NR>1 { if ($11 >= 4 && $11 < 5) print $4, $3, $5}" %data% | gmt plot -C%cpt% -Sc.1 -V
    gawk -F"|" "NR>1 { if ($11 >= 5 && $11 < 6) print $4, $3, $5}" %data% | gmt plot -C%cpt% -Sc.12 -V
    gawk -F"|" "NR>1 { if ($11 >= 6 && $11 < 7) print $4, $3, $5}" %data% | gmt plot -C%cpt% -Sc.14 -V
    
    
    gmt coast -Di -W.8 -A10000 -V
    
    REM ===== Plot faults =====
	rem gmt plot faults.txt -W1,0/0/0 -V
    gmt plot faults.txt -W1,0/0/0,2_1_2_1:0p -V
    
    REM ===== Beachballs =====
    gmt meca %mfile% -Sm0.3i+f10p -A -C+s2p -Fa -V 
    gawk "{print $1, $2}" %mfile% | gmt plot -Sa.2 -G0/0/0 -V
    
    REM ======= Plot Scale Points ===================
    echo 14.25 38 | gmt plot -Sc.01 -W1 -N -V
    echo 14.75 38 | gmt plot -Sc.06 -W1 -N -V
    echo 15.25 38 | gmt plot -Sc.08 -W1 -N -V
    echo 15.75 38 | gmt plot -Sc.1 -W1 -N -V
    echo 16.25 38 | gmt plot -Sc.12 -W1 -N -V
    echo 16.75 38 | gmt plot -Sc.14 -W1 -N -V
    REM ======= Plot Scale Text ====================
    echo 13.5 38 12,1,0 MC M@-L@- | gmt text -F+f+j -C0.01/0.01 -N -V
    echo 14.0 38 8,1 MC 2 | gmt text -F+f+j -Gyellow -N -V
    echo 14.5 38 8,1 MC 3 | gmt text -F+f+j -Gyellow -N -V
    echo 15.0 38 8,1 MC 4 | gmt text -F+f+j -Gyellow -N -V
    echo 15.5 38 8,1 MC 5 | gmt text -F+f+j -Gyellow -N -V
    echo 16.0 38 8,1 MC 6 | gmt text -F+f+j -Gyellow -N -V
    echo 16.5 38 8,1 MC 7 | gmt text -F+f+j -Gyellow -N -V
                                                                                                                                                                                                                                                                                                               
	gmt colorbar -C%cpt% -Dx0.0/-1.0+w3.0/0.1+h -Bx+l"Focal_depth" -By+l"km" -I -V -Y0.1
    
gmt end show
REM del *.conf *.history *.tmp
pause








