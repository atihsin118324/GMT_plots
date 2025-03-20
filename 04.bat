rem raw_service_response_Geological Feature View Service (EGDI Geological Map 1_1,000,000)
gmt set FORMAT_GEO_MAP ddd:mm:ssF

set in=D:\NTU\GMT\Final_report\data\lithology.tif
set out=D:\NTU\GMT\Final_report\data\lithology.grd
set cpt=D:\NTU\GMT\Final_report\cpt\lithology.cpt
set legend=D:\NTU\GMT\Final_report\data\lithology.legend
set in2=D:\NTU\GMT\Final_report\data\age.tif
set out2=D:\NTU\GMT\Final_report\data\age.grd
set cpt2=D:\NTU\GMT\Final_report\cpt\age.cpt
set legend2=D:\NTU\GMT\Final_report\data\age.legend

set range=12/14.3/42/44

gmt grdconvert %in%=gd:GTiff -G%out%=nf -V
gmt grdinfo %out% > lithology.info
type lithology.info

gmt grdconvert %in2%=gd:GTiff -G%out2%=nf -V
gmt grdinfo %out2% > age.info
type age.info

gmt makecpt -Chaxby -T50/260/20 > %cpt%
gmt makecpt -Chaxby -T50/300/40 > %cpt2%

gmt begin 04_geological jpg A+m0.5c
	gmt basemap -R%range% -Jm13.0/1.8i -Bxa0.5f0.5 -Bya0.5f0.5 -BWSen -V
	gmt grdimage %out% -C%cpt% -I+a45+ne1.0 -V
	gmt coast -R%range% -Jm13.0/1.8i -W0.1p -S212/231/237 -Lg14/43.8+w20+lkm -V
	rem gmt colorbar -C%cpt% -Dx2.0/-2.0+w10.0/0.3+h -V -Y0.1
	gmt legend %legend% -Dx1.5i/-0.4i+w3i/1.7i+jTC -Jx2i -R0/8/0/8 -V
	
	gmt basemap -R%range% -Jm13.0/1.8i -Bxa0.5f0.5 -Bya0.5f0.5 -BWSen -X6i -V
	gmt grdimage %out2% -C%cpt2% -I+a45+ne1.0 -V
	gmt coast -R%range% -Jm13.0/1.8i -W0.1p -S212/231/237 -Lg14/43.8+w20+lkm -V
	rem gmt colorbar -C%cpt2% -Dx2.0/-2.0+w10.0/0.3+h -V -Y0.1
	gmt legend %legend2% -Dx2i/-0.4i+w3i/1.7i+jTC -Jx2i -R0/8/0/8 -V
	
	
gmt end show
del *.conf *.history *.tmp *.info
pause