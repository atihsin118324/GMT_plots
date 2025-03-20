REM convert files 

set topography=D:\NTU\GMT\Final_report\data\topography.tif
set faults=D:\NTU\GMT\Final_report\data\faults.kml

set topography_out=D:\NTU\GMT\Final_report\data\topography.grd
set faults_out=D:\NTU\GMT\Final_report\data\faults.txt
set cpt=D:\NTU\GMT\Final_report\cpt\elevation.cpt 

gmt grdconvert %topography%=gd:GTiff -G%topography_out%=nf -V
gmt kml2gmt %faults% -V > %faults_out%

gmt makecpt -Cibcso -T-8000/0/250 -N > %cpt%
gmt makecpt -Celevation -T0/4000/250 >> %cpt% 

pause