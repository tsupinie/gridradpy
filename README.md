## gridradpy
A Python module for loading and QC-ing GridRad-Severe data (http://gridrad.org/index.html). `gridradpy` is based off the Python scripts available at http://gridrad.org/software.html. It has the same functions, but written using xarray. It also includes a download script that requires a free account at UCAR's [Research Data Archive](https://rda.ucar.edu/).

### Installation
```bash
# Install dependencies
conda env create -f environment.yml
conda activate gridradpy

# Install gridradpy
python setup.py install
```

### Usage
To use the download script:
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

To use the Python processing code:
```python
>>> import gridradpy
>>> data = gridradpy.read_file('/path/to/file.nc')                  # Read the gridrad file and unpack it from the 
                                                                    #   sparse storage scheme
>>> data = gridradpy.filter(data)                                   # Remove low-confidence data points
>>> data = gridradpy.remove_clutter(data, skip_weak_ll_echo=True)   # Remove areas of ground clutter
>>> gridradpy.plot_image(data, fname='gridrad_image.png')           # Plot a basic image, saving it to gridrad_image.png
```

### Differences from the Original Code
1) In the original code, the speckle filter fills the boundary with data from the opposite side. In this version, the boundaries of the coverage field are filled with the nearest valid data point. So that produces a different answer for the two grid points nearest the boundary.
2) The below-anvil clutter check finds areas with no reflectivity at 4 km collocated with reflectivity both above and below 4 km. In the original code, the check cuts off the topmost layer of both the above and below slices when it does the checking. I assume this is a mistake, and I have corrected it.
