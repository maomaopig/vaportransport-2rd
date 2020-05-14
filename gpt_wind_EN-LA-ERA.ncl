a1=addfile("/Volumes/results/results/2015/5.0/wks/CTL_ecmwf/gpt850_CTL.nc","r")
a2=addfile("/Volumes/results/results/2015/5.0/wks/CTL_ecmwf/gpt500_CTL.nc","r")
b1=addfile("/Volumes/results/results/2010/wks/CTL_ecmwf/CTL2/gpt850_CTL2.nc","r")
b2=addfile("/Volumes/results/results/2010/wks/CTL_ecmwf/CTL2/gpt500_CTL2.nc","r")
c=addfile("/Volumes/results/results/2015/5.0/ERA_result/wrfout_CTL.nc","r")
d1=addfile("/Volumes/results/results/2015/5.0/ERA_result/vapor/CTL/uv.nc","r")
d2=addfile("/Volumes/results/results/2010/wks/CTL_ecmwf/CTL2/uv2.nc","r")
e1=addfile("/Volumes/results/results/2015/5.0/wks/CTL_ecmwf/ERA5/ERA5_geopt_uv_monthlymean.nc","r") ;ERA
e1=addfile("/Volumes/results/results/2015/5.0/wks/CTL_ecmwf/ERA5/ERA5_geopt_uv_monthlymean.nc","r") ;ERA
e2=addfile("/Volumes/results/results/2010/wks/CTL_ecmwf/ERA5/ERA5_geopt_uv_monthlymean.nc","r")

gptaa1=a1->gpt850
gpta1=a1->gpt850(0:2,0,:,:)
gpta1(0,:,:)=dim_avg_n(gptaa1(245:982,0,:,:),0)/9.81
;gpta1(1,:,:)=dim_avg_n(gptaa1(487:735,0,:,:),0)/9.81
;gpta1(2,:,:)=dim_avg_n(gptaa1(735:982,0,:,:),0)/9.81
gpta1@units="gpm"
gpta1!1="lat"
gpta1!2="lon"
gpta1&lat=c->XLAT(0,:,0)
gpta1&lon=c->XLONG(0,0,:)

printVarSummary(gpta1)
delete(gptaa1)
delete(a1)

do i=0,2,1
do j=0,198,1
do k=0,238,1
if(gpta1(i,j,k) .gt. 1700) then
gpta1(i,j,k)=gpta1@_FillValue
end if 
end do
end do
end do

gptbb1=b1->gpt850
gptb1=b1->gpt850(0:2,0,:,:)

gptb1(0,:,:)=dim_avg_n(gptbb1(245:982,0,:,:),0)/9.81
;gptb1(1,:,:)=dim_avg_n(gptbb1(487:735,0,:,:),0)/9.81
;gptb1(2,:,:)=dim_avg_n(gptbb1(735:982,0,:,:),0)/9.81
gptb1@units="gpm"
gptb1!1="lat"
gptb1!2="lon"
gptb1&lat=c->XLAT(0,:,0)
gptb1&lon=c->XLONG(0,0,:)

printVarSummary(gptb1)
delete(gptbb1)
delete(b1)

do i=0,2,1
do j=0,198,1
do k=0,238,1
if(gptb1(i,j,k) .gt. 1700) then
gptb1(i,j,k)=gptb1@_FillValue
end if 
end do
end do
end do

gptaa2=a2->gpt500
gpta2=a2->gpt500(0:2,0,:,:)
gpta2(0,:,:)=dim_avg_n(gptaa2(245:982,0,:,:),0)/9.81
;gpta2(1,:,:)=dim_avg_n(gptaa2(487:735,0,:,:),0)/9.81
;gpta2(2,:,:)=dim_avg_n(gptaa2(735:982,0,:,:),0)/9.81
gpta2@units="gpm"
gpta2!1="lat"
gpta2!2="lon"
gpta2&lat=c->XLAT(0,:,0)
gpta2&lon=c->XLONG(0,0,:)

printVarSummary(gpta2)
delete(gptaa2)
delete(a2)

gptbb2=b2->gpt500
gptb2=b2->gpt500(0:2,0,:,:)
gptb2(0,:,:)=dim_avg_n(gptbb2(245:982,0,:,:),0)/9.81
;gptb2(1,:,:)=dim_avg_n(gptbb2(487:735,0,:,:),0)/9.81
;gptb2(2,:,:)=dim_avg_n(gptbb2(735:982,0,:,:),0)/9.81
gptb2@units="gpm"
gptb2!1="lat"
gptb2!2="lon"
gptb2&lat=c->XLAT(0,:,0)
gptb2&lon=c->XLONG(0,0,:)

printVarSummary(gptb2)
delete(gptbb2)
delete(b2)

u1=dim_avg_n(d1->u(245:982,:,:,:),0) ;3=850,10=500
v1=dim_avg_n(d1->v(245:982,:,:,:),0)

u1!1="lat"
u1!2="lon"
v1!1="lat"
v1!2="lon"

u1&lat=c->XLAT(0,:,0)
u1&lon=c->XLONG(0,0,:)
v1&lat=c->XLAT(0,:,0)
v1&lon=c->XLONG(0,0,:)

delete(d1)

u2=dim_avg_n(d2->u(245:982,:,:,:),0) ;3=850,10=500
v2=dim_avg_n(d2->v(245:982,:,:,:),0)

u2!1="lat"
u2!2="lon"
v2!1="lat"
v2!2="lon"

u2&lat=c->XLAT(0,:,0)
u2&lon=c->XLONG(0,0,:)
v2&lat=c->XLAT(0,:,0)
v2&lon=c->XLONG(0,0,:)

delete(d2)

gptbb3=lonFlip(short2flt(e1->z(:,:,::-1,:)))
gptbb3!2="lat"
gptbb3!3="lon"
gpte1=gptbb3(:,1,{min(gpta1&lat):max(gpta1&lat)},{min(gpta1&lon):max(gpta1&lon)})
gpte1(0,:,:)=dim_avg_n(gpte1,0)/9.81

gpte2=gptbb3(:,0,{min(gpta1&lat):max(gpta1&lat)},{min(gpta1&lon):max(gpta1&lon)})
gpte2(0,:,:)=dim_avg_n(gpte2,0)/9.81

delete(gptbb3)

uu3=lonFlip(short2flt(e1->u(:,:,::-1,:)))
u3=uu3(:,:,{min(gpta1&lat):max(gpta1&lat)},{min(gpta1&lon):max(gpta1&lon)})
u3(0,:,:,:)=dim_avg_n(u3,0)

vv3=lonFlip(short2flt(e1->v(:,:,::-1,:)))
v3=vv3(:,:,{min(gpta1&lat):max(gpta1&lat)},{min(gpta1&lon):max(gpta1&lon)})
v3(0,:,:,:)=dim_avg_n(v3,0)

delete(uu3)
delete(vv3)

delete(e1)

gptbb4=lonFlip(short2flt(e2->z(:,:,::-1,:)))
gptbb4!2="lat"
gptbb4!3="lon"
gpte3=gptbb4(:,1,{min(gpta1&lat):max(gpta1&lat)},{min(gpta1&lon):max(gpta1&lon)})
gpte3(0,:,:)=dim_avg_n(gpte3,0)/9.81

gpte4=gptbb4(:,0,{min(gpta1&lat):max(gpta1&lat)},{min(gpta1&lon):max(gpta1&lon)})
gpte4(0,:,:)=dim_avg_n(gpte4,0)/9.81

delete(gptbb4)

uu4=lonFlip(short2flt(e2->u(:,:,::-1,:)))
u4=uu4(:,:,{min(gpta1&lat):max(gpta1&lat)},{min(gpta1&lon):max(gpta1&lon)})
u4(0,:,:,:)=dim_avg_n(u4,0)

vv4=lonFlip(short2flt(e2->v(:,:,::-1,:)))
v4=vv4(:,:,{min(gpta1&lat):max(gpta1&lat)},{min(gpta1&lon):max(gpta1&lon)})
v4(0,:,:,:)=dim_avg_n(v4,0)

delete(uu4)
delete(vv4)

delete(e2)

wks = gsn_open_wks("x11","EN-LA-ERA_gpt_wind")

cmap = read_colormap_file("grads_rainbow")
  
plot = new(8,graphic)

;;set map;;
        mpres                             = True
        mpres@mpDataSetName               = "/Volumes/results/NCL-Chinamap/database/Earth..4"
        mpres@mpDataBaseVersion           = "MediumRes"
        mpres@mpOutlineOn                 = True
        mpres@mpOutlineSpecifiers         = (/"China"/)
        mpres@mpGeophysicalLineThicknessF = 2
;       mpres@mpFillDrawOrder             = "PostDraw"
;       mpres@mpFillOn                    = True
;       mpres@mpFillAreaSpecifiers        = (/"water",       "land" /)
;       mpres@mpSpecifiedFillColors       = (/"deepskyblue2","white"/)
;       mpres@mpSpecifiedFillColors      = (/100,0/)
        mpres@mpMaskAreaSpecifiers        = (/"China"/)

	mpres@mpLandFillColor            = "white"
		
    mpres@mpInlandWaterFillColor     = "white"
    mpres@mpOceanFillColor           = "white"
    mpres@mpFillBoundarySets         = "NoBoundaries"
    mpres@mpOutlineBoundarySets      = "NoBoundaries"
    mpres@mpNationalLineThicknessF   = 4
    mpres@mpProvincialLineThicknessF = 3
    
    mpres@mpOutlineBoundarySets = "Geophysical"
    ;mpres@mpGeophysicalLineThicknessF = 3
    mpres@mpGeophysicalLineColor    = "White"
    mpres@mpNationalLineColor       = "White"

    mpres@mpMinLonF    = min(gptb1&lon) ;30. ;min(lon) ;50
    mpres@mpMaxLonF    = max(gptb1&lon) ;135. ; max(lon) ;140
    mpres@mpMinLatF    = min(gptb1&lat) ;10.  ;min(lat) ;0
    mpres@mpMaxLatF    = max(gptb1&lat) ;60.  ;max(lat) ;60
    mpres@gsnDraw                 = False
    mpres@gsnFrame                 = False


    mpres@tmYLLabelsOn               = False            ; turn off lat labels
    mpres@tmXBLabelsOn               = False            ; turn off lon labels
    mpres@tmYLOn                     = False
    mpres@tmXTOn                     = False
    mpres@tmXBOn                     = False
    mpres@tmYROn                     = False


res     =       True
res@gsnDraw      = False
res@gsnFrame     = False
;res@mpMinLonF    = min(gptb1&lon)
;res@mpMaxLonF    = max(gptb1&lon)
;res@mpMinLatF    = min(gptb1&lat)
;res@mpMaxLatF    = max(gptb1&lat)
;res@mpOutlineBoundarySets = "National"
;res@mpGeophysicalLineThicknessF = 2.
;res@mpGeophysicalLineColor    = "White" ;"gray30"
;res@mpNationalLineThicknessF  = 1.
;res@mpNationalLineColor       ="White" ;"gray20"


res@gsnCenterString        = " "
;res@lbOrientation        = "Vertical"
res@cnFillOn             =  True
res@cnFillPalette        = cmap
res@cnLevelSelectionMode = "ManualLevels"
res@cnLinesOn       = False
res@cnLineLabelsOn        = True        ; Turn on contour line labels
res@cnLineLabelInterval     =5.
res@cnMaxLevelValF       =1640.
res@cnMinLevelValF       =1300.
res@cnLevelSpacingF      = 20.
res@gsnAddCyclic       = False
res@lbLabelBarOn        = False
res@cnLineLabelBackgroundColor = 0.
res@cnInfoLabelOn = False 

;wind
vcres                         = True
vcres@vcGlyphStyle            = "CurlyVector"
vcres@vcLineArrowColor        = "Black"
vcres@gsnDraw                 = False
vcres@gsnFrame                = False
vcres@vcFillArrowsOn          = True
vcres@gsnRightString          = " "
vcres@gsnLeftString           = " "
vcres@vcRefMagnitudeF         = 15.0             ; define vector ref mag
vcres@vcRefLengthF            = 0.03             ; define length of vec ref
vcres@vcMinFracLengthF        = 0.3
vcres@vcMinDistanceF          = 0.02
vcres@vcRefAnnoOrthogonalPosF = -0.18
vcres@vcRefAnnoFontHeightF    = 0.012
vcres@gsnAddCyclic       = False


res@gsnRightString       = " "
res@gsnLeftString         = " "

vcres@vcRefAnnoString2On = False 
;vcres@vcRefAnnoString1On = False 

mpres@tmXBLabelFontHeightF = 0.02
mpres@tmYLLabelFontHeightF = 0.02

;resizing

mpres@mpShapeMode  = "FreeAspect"
mpres@vpWidthF      = 0.8
mpres@vpHeightF     = 0.4


;;add a title
  txres                       = True
  txres@txPerimOn             = False
  txres@txBackgroundFillColor = "White"
  txres@txFontHeightF         = 0.02
  txres@txJust                ="TopLeft"; place the string to the left

  amres = True
 ; amres@amSide            = "LEFT"
  amres@amParallelPosF   = -0.4    ; This is the left edge of the plot.
  amres@amOrthogonalPosF = -0.43    ; This is the bottom edge of the plot.
;;add a title 

    mpres@tmYLLabelsOn               = True            ; turn off lat labels
    mpres@tmYRLabelsOn               = False            ; turn off lat labels
    mpres@tmXBLabelsOn               = False           ; turn off lon labels
    mpres@tmXTLabelsOn               = False             ; turn off lon labels
    mpres@tmYLOn                     = True
    mpres@tmXTOn                     = False 
    mpres@tmXBOn                     = False 
    mpres@tmYROn                     = False

map0 = gsn_csm_map(wks,mpres)
gpt_plot_1   =  gsn_csm_contour(wks,gpta1(0,:,:),res)
uv_plot_1    = gsn_csm_streamline(wks,u1(3,:,:),v1(3,:,:),vcres)
overlay(gpt_plot_1,uv_plot_1)
overlay(map0,gpt_plot_1)
plot(0)            = map0


;;add a title
  txid0 = gsn_create_text(wks, "(a)15 WRF", txres)
  annoid0 = gsn_add_annotation(plot(0), txid0, amres)  ; Attach string to plot
;;add a title

    mpres@tmYLLabelsOn               = True            ; turn off lat labels
    mpres@tmYRLabelsOn               = False            ; turn off lat labels
    mpres@tmXBLabelsOn               = False           ; turn off lon labels
    mpres@tmXTLabelsOn               = False             ; turn off lon labels
    mpres@tmYLOn                     = True
    mpres@tmXTOn                     = False 
    mpres@tmXBOn                     = False 
    mpres@tmYROn                     = False


map1 = gsn_csm_map(wks,mpres)
gpt_plot_2 =  gsn_csm_contour(wks,gptb1(0,:,:),res)
uv_plot_2    = gsn_csm_vector(wks,u2(3,:,:),v2(3,:,:),vcres)
overlay(gpt_plot_2,uv_plot_2)
overlay(map1,gpt_plot_2)
plot(2)            = map1

;;add a title
  txid1 = gsn_create_text(wks, "(e)10 WRF", txres)
  annoid1 = gsn_add_annotation(plot(2), txid1, amres)  ; Attach string to plot
;;add a title

    mpres@tmYLLabelsOn               = True            ; turn off lat labels
    mpres@tmYRLabelsOn               = False            ; turn off lat labels
    mpres@tmXBLabelsOn               = False          ; turn off lon labels
    mpres@tmXTLabelsOn               = False             ; turn off lon labels
    mpres@tmYLOn                     = True
    mpres@tmXTOn                     = False 
    mpres@tmXBOn                     = False 
    mpres@tmYROn                     = False


map4 = gsn_csm_map(wks,mpres)
gpt_plot_5   =  gsn_csm_contour(wks,gpte1(0,:,:),res)
uv_plot_5    = gsn_csm_vector(wks,u3(0,1,:,:),v3(0,1,:,:),vcres)
overlay(gpt_plot_5,uv_plot_5)
overlay(map4,gpt_plot_5)
plot(1)            = map4


;;add a title
  txid3 = gsn_create_text(wks, "(c)15 ERA", txres)
  annoid3 = gsn_add_annotation(plot(1), txid3, amres)  ; Attach string to plot
;;add a title

    mpres@tmYLLabelsOn               = True            ; turn off lat labels
    mpres@tmYRLabelsOn               = False            ; turn off lat labels
    mpres@tmXBLabelsOn               = True          ; turn off lon labels
    mpres@tmXTLabelsOn               = False             ; turn off lon labels
    mpres@tmYLOn                     = True
    mpres@tmXTOn                     = False 
    mpres@tmXBOn                     = True 
    mpres@tmYROn                     = False


map6 = gsn_csm_map(wks,mpres)
gpt_plot_7   =  gsn_csm_contour(wks,gpte3(0,:,:),res)
uv_plot_7    = gsn_csm_vector(wks,u4(0,1,:,:),v4(0,1,:,:),vcres)
overlay(gpt_plot_7,uv_plot_7)
overlay(map6,gpt_plot_7)
plot(3)            = map6


;;add a title
  txid5 = gsn_create_text(wks, "(g)10 ERA", txres)
  annoid5 = gsn_add_annotation(plot(3), txid5, amres)  ; Attach string to plot
;;add a title




res@cnMaxLevelValF       =6040.
res@cnMinLevelValF       =5400.
res@cnLevelSpacingF      = 40.

    mpres@tmYLLabelsOn               = False            ; turn off lat labels
    mpres@tmYRLabelsOn               = True            ; turn off lat labels
    mpres@tmXBLabelsOn               = False           ; turn off lon labels
    mpres@tmXTLabelsOn               = False             ; turn off lon labels
    mpres@tmYLOn                     = False
    mpres@tmXTOn                     = False 
    mpres@tmXBOn                     = False 
    mpres@tmYROn                     = True

map2 = gsn_csm_map(wks,mpres)
gpt_plot_3  =  gsn_csm_contour(wks,gpta2(0,:,:),res)
uv_plot_3    = gsn_csm_vector(wks,u1(10,:,:),v1(10,:,:),vcres)
overlay(gpt_plot_3,uv_plot_3)
overlay(map2,gpt_plot_3)
plot(4)            = map2


;;add a title
  txid2 = gsn_create_text(wks, "(b)15 WRF", txres)
  annoid2 = gsn_add_annotation(plot(4), txid2, amres)  ; Attach string to plot
;;add a title

    mpres@tmYLLabelsOn               = False            ; turn off lat labels
    mpres@tmYRLabelsOn               = True            ; turn off lat labels
    mpres@tmXBLabelsOn               = False           ; turn off lon labels
    mpres@tmXTLabelsOn               = False             ; turn off lon labels
    mpres@tmYLOn                     = False
    mpres@tmXTOn                     = False 
    mpres@tmXBOn                     = False 
    mpres@tmYROn                     = True
map3 = gsn_csm_map(wks,mpres)
gpt_plot_4=gsn_csm_contour(wks,gptb2(0,:,:),res)
uv_plot_4    = gsn_csm_vector(wks,u2(10,:,:),v2(10,:,:),vcres)
overlay(gpt_plot_4,uv_plot_4)
overlay(map3,gpt_plot_4)
plot(6)            = map3

;;add a title
  txid3 = gsn_create_text(wks, "(f)10 WRF", txres)
  annoid3 = gsn_add_annotation(plot(6), txid3, amres)  ; Attach string to plot
;;add a title

    mpres@tmYLLabelsOn               = False            ; turn off lat labels
    mpres@tmYRLabelsOn               = True            ; turn off lat labels
    mpres@tmXBLabelsOn               = False           ; turn off lon labels
    mpres@tmXTLabelsOn               = False             ; turn off lon labels
    mpres@tmYLOn                     = False
    mpres@tmXTOn                     = False 
    mpres@tmXBOn                     = False 
    mpres@tmYROn                     = True

map5 = gsn_csm_map(wks,mpres)
gpt_plot_6   =  gsn_csm_contour(wks,gpte2(0,:,:),res)
uv_plot_6   = gsn_csm_vector(wks,u3(0,0,:,:),v3(0,0,:,:),vcres)
overlay(gpt_plot_6,uv_plot_6)
overlay(map5,gpt_plot_6)
plot(5)            = map5

;;add a title
  txid5 = gsn_create_text(wks, "(d)15 ERA", txres)
  annoid5 = gsn_add_annotation(plot(5), txid5, amres)  ; Attach string to plot
;;add a titl

    mpres@tmYLLabelsOn               = False            ; turn off lat labels
    mpres@tmYRLabelsOn               = True            ; turn off lat labels
    mpres@tmXBLabelsOn               = True           ; turn off lon labels
    mpres@tmXTLabelsOn               = False             ; turn off lon labels
    mpres@tmYLOn                     = False
    mpres@tmXTOn                     = False 
    mpres@tmXBOn                     = True 
    mpres@tmYROn                     = True

map7 = gsn_csm_map(wks,mpres)
gpt_plot_8   =  gsn_csm_contour(wks,gpte4(0,:,:),res)
uv_plot_8   = gsn_csm_vector(wks,u4(0,0,:,:),v4(0,0,:,:),vcres)
overlay(gpt_plot_8,uv_plot_8)
overlay(map7,gpt_plot_8)
plot(7)            = map7


;;add a title
  txid5 = gsn_create_text(wks, "(h)10 ERA", txres)
  annoid5 = gsn_add_annotation(plot(7), txid5, amres)  ; Attach string to plot
;;add a title
 ;************************************************
 ; create panel
 ;************************************************

   resP                     = True                ; modify the panel plot
   resP@gsnPanelLabelBar    = True              ; add common colorbar
 ; resP@gsnAttachBorderOn = False
 
  resP@lbAutoManage          = False             ; we control label bar
  resP@LabelBarDisplayMode = "Always"          ; turns on label bar
  resP@lbOrientation         = "Vertical"      ; ncl default is vertical
  ;resP@LabelBarSide        = "Left"          ; default is right
  resP@lbLabelStride         = 2                 ; skip every other label
  resP@pmLabelBarWidthF      = 0.4               ; default is shorter
  resP@pmLabelBarHeightF     = 0.1               ; default is taller
  ;resP@lbLabelFontHeightF    = .022              ; default is HUGE
  resP@lbPerimOn             = False             ; default has box


 ;change the size of the plots
   ; resP@gsnMaximize            = True
    resP@gsnPanelScalePlotIndex      = 1
    resP@gsnPaperOrientation = "portrait" 
  ; resP@gsnPanelDebug       = True
    resP@gsnFrame            = False

   resP@gsnPanelYWhiteSpacePercent =0.0
   resP@gsnPanelXWhiteSpacePercent =0.0


  res@gsnDraw      =True

  res_U                   = True
  res_U@gsnFrame          = False
  res_U@gsnPanelBottom = 0.01
  res_U@gsnPanelLeft =  0.005
  res_U@gsnPanelRight = 0.5
  res_U@gsnPanelLabelBar  = True
  res_U@gsnPanelScalePlotIndex      = 1
  res_U@gsnPaperOrientation = "portrait" 
  res_U@gsnPanelYWhiteSpacePercent =0.0
  res_U@gsnPanelXWhiteSpacePercent =0.0
  ;res_U@lbOrientation         = "Vertical"
  res_U@pmLabelBarWidthF      = 0.4               ; default is shorter
  res_U@pmLabelBarHeightF     = 0.05               ; default is taller
  res_U@lbLabelFontHeightF    = .01              ; default is HUGE
  
  res_L                   = True
  res_L@gsnFrame          = False
  res_L@gsnPanelBottom = 0.01
  res_L@gsnPanelRight = 0.995
  res_L@gsnPanelLeft = 0.5
  res_L@gsnPanelLabelBar  = True
  res_L@gsnPanelScalePlotIndex      = 1
  res_L@gsnPaperOrientation = "portrait" 
  res_L@gsnPanelYWhiteSpacePercent =0.0
  res_L@gsnPanelXWhiteSpacePercent =0.0
  ;res_L@lbOrientation         = "Vertical"  
  res_L@pmLabelBarWidthF      = 0.4               ; default is shorter
  res_L@pmLabelBarHeightF     = 0.05               ; default is taller
  res_L@lbLabelFontHeightF    = .01             ; default is HUGE
  

  gsn_panel(wks,plot(0:3),(/4,1/),res_U)               ; now draw as one plot
  gsn_panel(wks,plot(4:7),(/4,1/),res_L)               ; now draw as one plot
frame(wks)
