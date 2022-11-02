#+
# Name:
#		GRIDRAD Python Module
# Purpose:
#		This module contains three functions for dealing with Gridded NEXRAD WSR-88D Radar
#		(GridRad) data: reading (read_file), filtering (filter), and decluttering (remove_clutter).
# Author and history:
#		Cameron R. Homeyer  2017-07-03.
#                         2021-02-23. Updated to be compatible with v4.2 GridRad data and v3 Python.
#       Tim Supinie 2022-10-28. Updated to use xarray
#-

from .gridrad import read_file, filter, remove_clutter, plot_image
from .download import GridRadDownloader