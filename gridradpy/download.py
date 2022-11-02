
import http.cookiejar
import getpass
import urllib.request as urlreq
import urllib.error as urlerr
import shutil
from pathlib import Path
from datetime import datetime, timedelta
from typing import Union

class GridRadDownloader:
    def __init__(self):
        self._cj = http.cookiejar.MozillaCookieJar()
        self._opener = urlreq.build_opener(urlreq.HTTPCookieProcessor(self._cj))

    def download_file(self, dt: datetime, loc_fname: Union[str, Path], verbose=True) -> None:
        #
        # download the data file(s)

        conv_dt = dt - timedelta(hours=12)
        file = f"volumes/{conv_dt:%Y}/{conv_dt:%Y%m%d}/nexrad_3d_v4_2_{dt:%Y%m%dT%H%M%S}Z.nc"
        ofile = loc_fname
        
        if verbose:
            print(f"Downloading {ofile} ... ", end="", flush=True)

        rem_fname = f"http://rda.ucar.edu/data/OS/ds841.6/{file}"

        try:
            frem = self._opener.open(rem_fname)
        except urlerr.HTTPError:
            if verbose:
                print("not found.")

            return

        with open(ofile, 'wb') as floc:
            shutil.copyfileobj(frem, floc)

        if verbose:
            print("done.")

    def login(self, email: str, auth_path=Path('.')) -> None:    
        # check for existing cookies file and authenticate if necessary
        do_authentication = False

        auth_file = auth_path / 'auth.rda.ucar.edu'
        if auth_file.exists():
            self._cj.load(auth_file, False, True)

        for cookie in self._cj:
            if (cookie.name == "sess" and cookie.is_expired()):
                do_authentication=True
        else:
            do_authentication=True

        if do_authentication:
            passwd = getpass.getpass(prompt="Enter RDA Password: ")
            login = self._opener.open("https://rda.ucar.edu/cgi-bin/login", f"email={email}&password={passwd}&action=login".encode('utf-8'))

        #
        # save the authentication cookies for future downloads
        # NOTE! - cookies are saved for future sessions because overly-frequent authentication to our server can cause your data access to be blocked
        self._cj.clear_session_cookies()
        self._cj.save(auth_file, True, True)