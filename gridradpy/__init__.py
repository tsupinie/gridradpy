
from pathlib import Path
from typing import Union

from .gridrad import read_file, filter, remove_clutter, plot_image
from .download import GridRadDownloader

_remove_clutter_ = remove_clutter

def load_and_process_file(fname: Union[str, Path], filter_low_confidence=True, remove_clutter=True):
    ds = read_file(fname)
    
    if filter_low_confidence:
        ds = filter(ds)

    if remove_clutter:
        ds = _remove_clutter_(ds, skip_weak_ll_echo=True)
    
    return ds