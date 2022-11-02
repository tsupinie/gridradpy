## gridradpy
A Python module for loading and QC-ing GridRad-Severe data (http://gridrad.org/index.html). `gridradpy` is based off the Python scripts available at http://gridrad.org/software.html. It has the same functions, but written using xarray. It also includes a download script that requires a free account on UCAR's [Research Data Archive (RDA)](https://rda.ucar.edu/).

### Installation
```bash
# Install dependencies
conda env create -f environment.yml
conda activate gridradpy

# Install gridradpy
python setup.py install
```

### Usage
The download script can download a bunch of data files in a given time interval with one script invocation. To use the download script:
```
usage: download_gridrad [-h] --email EMAIL --dt-start DT_START --dt-end DT_END [--td-step TD_STEP] [--out-path OUT_PATH] [--force-download]

options:
  -h, --help           show this help message and exit
  --email EMAIL        Email address to use for authentication in the UCAR RDA
  --dt-start DT_START  Start time for data download (YYYYMMDD_HHMM format)
  --dt-end DT_END      End time for data download (YYYYMMDD_HHMM format)
  --td-step TD_STEP    Time step for data download (ISO 8601 format; defaults to 'PT5M', or 5 minutes)
  --out-path OUT_PATH  Path to download data to (defaults to the current directory)
  --force-download     If specified, overwrite files already downloaded; otherwise, skip previously downloaded files
```
The download script will prompt for your RDA password when run.

To use the Python code:
```python
>>> import gridradpy
>>> from gridradpy import GridRadDownloader
>>> from datetime import datetime
>>>
>>> grd = GridRadDownloader()
>>> grd.login('user@example.com')                                   # Login with your RDA email and password (only do
                                                                    #   this once per script invocation)
Enter RDA Password:
>>> local_fname = '/path/to/gridrad/gridrad_v4_2_20110427_2200.nc'
>>> grd.download_file(datetime(2011, 4, 27, 22, 0), local_fname)    # Download data from 2200 UTC 27 April 2011
                                                                    #   to the local disk
>>>
>>> data = gridradpy.read_file(local_fname)                         # Read the gridrad file and unpack it from the 
                                                                    #   sparse storage scheme
>>> data = gridradpy.filter(data)                                   # Remove low-confidence data points
>>> data = gridradpy.remove_clutter(data, skip_weak_ll_echo=True)   # Remove areas of ground clutter
>>> data = gridradpy.load_and_process_file(local_fname)             # Shorthand that does the same thing the above 3 
                                                                    #   function calls
>>> data
<xarray.Dataset>
Dimensions:         (Longitude: 792, Latitude: 792, Altitude: 29, Sweep: 1691,
                     time: 1)
Coordinates:
  * Longitude       (Longitude) float64 267.5 267.5 267.6 ... 283.9 284.0 284.0
  * Latitude        (Latitude) float64 27.51 27.53 27.55 ... 43.95 43.97 43.99
  * Altitude        (Altitude) float64 0.5 1.0 1.5 2.0 ... 19.0 20.0 21.0 22.0
  * time            (time) datetime64[ns] 2011-04-27T22:00:00
Dimensions without coordinates: Sweep
Data variables:
    sweeps_merged   (Sweep) |S29 ...
    Nradobs         (Altitude, Latitude, Longitude) int8 0 0 0 0 0 ... 4 3 1 1 3
    Nradecho        (Altitude, Latitude, Longitude) int8 ...
    Reflectivity    (Altitude, Latitude, Longitude) float32 nan nan ... nan nan
    wReflectivity   (Altitude, Latitude, Longitude) float32 nan nan ... nan nan
    SpectrumWidth   (Altitude, Latitude, Longitude) float32 nan nan ... nan nan
    wSpectrumWidth  (Altitude, Latitude, Longitude) float32 nan nan ... nan nan
    AzShear         (Altitude, Latitude, Longitude) float32 nan nan ... nan nan
    wAzShear        (Altitude, Latitude, Longitude) float32 nan nan ... nan nan
    Divergence      (Altitude, Latitude, Longitude) float32 nan nan ... nan nan
    wDivergence     (Altitude, Latitude, Longitude) float32 nan nan ... nan nan
Attributes: (12/16)
    Name:                   GridRad
    Description:            Three-dimensional gridded NEXRAD radar reflectivi...
    Analysis_time:          2011-04-27 22:00:00Z
    Analysis_time_window:   all azimuth scans (elevation angles) with central...
    Algorithm_version:      v4_2
    Algorithm_description:  Space and time binning weighted by distances from...
    ...                     ...
    Storage_scheme:         netCDF-4, sparse
    Data_source:            Amazon Web Services
    Data_source_URL:        https://www.ncdc.noaa.gov/data-access/radar-data/...
    Authors:                Cameron R. Homeyer, School of Meteorology, Univer...
    Project_sponsor:        National Oceanic and Atmospheric Administration, ...
    Project_name:           0-3 Hour Tornado Prediction Using the Warn on For...
>>> gridradpy.plot_image(data, fname='gridrad_image.png')           # Plot a basic image, saving it to gridrad_image.png
```

### Differences from the Original Code
1) In the original code, the speckle filter fills the boundary with data from the opposite side. In this version, the boundaries of the coverage field are filled with the nearest valid data point. So that produces a different answer for the two grid points nearest the boundary.
2) The below-anvil clutter check finds areas with no reflectivity at 4 km collocated with reflectivity both above and below 4 km. In the original code, the check cuts off the topmost layer of both the above and below slices when it does the checking. I assume this is a mistake, and I have corrected it.
