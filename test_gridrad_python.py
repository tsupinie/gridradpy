import gridradpy

fname = '/Users/tsupinie/data/gridrad/nexrad_3d_v4_2_20110426T220000Z.nc'

data_xr = gridradpy.read_file(fname)
data_xr = gridradpy.filter(data_xr)
data_xr = gridradpy.remove_clutter(data_xr, skip_weak_ll_echo=True)
plot = gridradpy.plot_image(data_xr, 'gridrad_image_xr.png')
