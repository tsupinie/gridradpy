import gridrad

fname = '/Users/tsupinie/data/gridrad/nexrad_3d_v4_2_20110426T220000Z.nc'

data_xr = gridrad.read_file(fname)
data_xr = gridrad.filter(data_xr)
data_xr = gridrad.remove_clutter(data_xr, skip_weak_ll_echo=True)
plot = gridrad.plot_image(data_xr, 'gridrad_image_xr.png')
