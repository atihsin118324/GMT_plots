gmt set MAP_FRAME_TYPE = plain

set topography=D:\NTU\GMT\Final_report\data\ETOPO1_Bed_g_gmt4.grd
set cpt=D:\NTU\GMT\Final_report\data\gray.cpt 
set faults=D:\NTU\GMT\Final_report\data\faults.txt
set boundaries=D:\NTU\GMT\Final_report\data\PB2002_boundaries.dig.txt
set EU_plate=D:\NTU\GMT\Final_report\data\EU_plates.txt
set AF_plate=D:\NTU\GMT\Final_report\data\AF_plates.txt
set AS_plate=D:\NTU\GMT\Final_report\data\AS_plates.txt
set AT_plate=D:\NTU\GMT\Final_report\data\AT_plates.txt
set plates=D:\NTU\GMT\Final_report\data\PB2002_plates.dig.txt

set range=-10/38/32/52

gmt makecpt -Cibcso -T-5000/0/250 > %cpt%
gmt makecpt -Cgray -T0/4000/250 -I >> %cpt%

gmt begin 05_Europe jpg
	gmt grdcut %topography% -Ggrd.tmp -R%range%
	gmt grdgradient grd.tmp -A310 -Gint.tmp -Ne.5 -fg -V
	gmt grdimage -R%range% -Jm15/0/.2i grd.tmp -Iint.tmp -C%cpt% -V
	gmt coast -R%range% -Jm15/0/.2i -Ba5f5 -B+t"Active faults and plate boundaries" -Lg-6/45+w500+f+lkm -N1/0.5p,- -W1/0.5p,white -U -Tdg-8/43+w1.5c+f2 -V
	gmt colorbar -Dx5c/-2c+w10c/0.3c+h -C%cpt% -By+lm -Bxf500a2000 -I -V 
	
	REM plate boundaries
	gmt plot %boundaries% -W2p,orange -l"PB2002_boundaries"+jTL -V
	gmt plot %EU_plate% -W2p,orange -Gwhite -t100 -l"Eurasian Plate"+jTL -V
	gmt plot %AF_plate% -W2p,orange -Gblue -t60 -l"African Plate"+jTL -V
	gmt plot %AS_plate% -W2p,orange -Gred -t70 -l"Aegean Sea Plate"+jTL -V
	gmt plot %AT_plate% -W2p,orange -Ggreen -t70 -l"Anatolian Plate"+jTL -V
	gmt plot %faults% -W1p,red -l"active faults"+jTL -V
	
	REM inset
	gmt inset begin -DjTR+w4c+o0.1c 
	gmt coast -Rg -JG10/40/1.5i -W0.01 -Di -Bg30 -A1000 -Ggray -N1/0.25p,snow -V
	echo -10 32 38 52 | gmt plot -Sr+s -W1p,blue
	gmt inset end 
	
gmt end show
del *.tmp
pause 