import gridrad
data = gridrad.read_file('/data1/GRIDRAD_SEVERE/level2/composite/v4_2/2011/20110531/nexrad_3d_v4_2_20110601T000000Z.nc')
data = gridrad.filter(data)
data = gridrad.remove_clutter(data, skip_weak_ll_echo=1)
plot = gridrad.plot_image(data)
