#! /bin/csh -f
#
# c-shell script to download selected files from <server_name> using curl
# NOTE: if you want to run under a different shell, make sure you change
#       the 'set' commands according to your shell's syntax
# after you save the file, don't forget to make it executable
#   i.e. - "chmod 755 <name_of_script>"
#
# you can add cURL options here (progress bars, etc.)
set opts = ""
#
# Replace "xxxxxx" with your rda.ucar.edu password on the next uncommented line
# IMPORTANT NOTE:  If your password uses a special character that has special meaning
#                  to csh, you should escape it with a backslash
#                  Example:  set passwd = "my\!password"
stty -echo 
echo -n "Enter password: "
set passwd = $<
stty echo

set num_chars = `echo "$passwd" |awk '{print length($0)}'`
@ num = 1
set newpass = ""
while ($num <= $num_chars)
  set c = `echo "$passwd" |cut -b{$num}-{$num}`
  if ("$c" == "&") then
    set c = "%26";
  else
    if ("$c" == "?") then
      set c = "%3F"
    else
      if ("$c" == "=") then
        set c = "%3D"
      endif
    endif
  endif
  set newpass = "$newpass$c"
  @ num ++
end
set passwd = "$newpass"
#
if ("$passwd" == "xxxxxx") then
  echo "You need to set your password before you can continue"
  echo "  see the documentation in the script"
  exit
endif

set out_path = /Users/tsupinie/data/gridrad

#
# authenticate - NOTE: You should only execute this command ONE TIME.
# Executing this command for every data file you download may cause
# your download privileges to be suspended.
curl -o auth_status.rda.ucar.edu -k -s -c auth.rda.ucar.edu.$$ -d "email=tsupinie@ou.edu&passwd=$passwd&action=login" https://rda.ucar.edu/cgi-bin/login
#
# download the file(s)
# NOTE:  if you get 403 Forbidden errors when downloading the data files, check
#        the contents of the file 'auth_status.rda.ucar.edu'
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T220000Z.nc -o $out_path/nexrad_3d_v4_2_20110426T220000Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T220500Z.nc -o $out_path/nexrad_3d_v4_2_20110426T220500Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T221000Z.nc -o $out_path/nexrad_3d_v4_2_20110426T221000Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T221500Z.nc -o $out_path/nexrad_3d_v4_2_20110426T221500Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T222000Z.nc -o $out_path/nexrad_3d_v4_2_20110426T222000Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T222500Z.nc -o $out_path/nexrad_3d_v4_2_20110426T222500Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T223000Z.nc -o $out_path/nexrad_3d_v4_2_20110426T223000Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T223500Z.nc -o $out_path/nexrad_3d_v4_2_20110426T223500Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T224000Z.nc -o $out_path/nexrad_3d_v4_2_20110426T224000Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T224500Z.nc -o $out_path/nexrad_3d_v4_2_20110426T224500Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T225000Z.nc -o $out_path/nexrad_3d_v4_2_20110426T225000Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T225500Z.nc -o $out_path/nexrad_3d_v4_2_20110426T225500Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T230000Z.nc -o $out_path/nexrad_3d_v4_2_20110426T230000Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T230500Z.nc -o $out_path/nexrad_3d_v4_2_20110426T230500Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T231000Z.nc -o $out_path/nexrad_3d_v4_2_20110426T231000Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T231500Z.nc -o $out_path/nexrad_3d_v4_2_20110426T231500Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T232000Z.nc -o $out_path/nexrad_3d_v4_2_20110426T232000Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T232500Z.nc -o $out_path/nexrad_3d_v4_2_20110426T232500Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T233000Z.nc -o $out_path/nexrad_3d_v4_2_20110426T233000Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T233500Z.nc -o $out_path/nexrad_3d_v4_2_20110426T233500Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T234000Z.nc -o $out_path/nexrad_3d_v4_2_20110426T234000Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T234500Z.nc -o $out_path/nexrad_3d_v4_2_20110426T234500Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T235000Z.nc -o $out_path/nexrad_3d_v4_2_20110426T235000Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110426T235500Z.nc -o $out_path/nexrad_3d_v4_2_20110426T235500Z.nc
curl $opts -k -b auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/OS/ds841.6/volumes/2011/20110426/nexrad_3d_v4_2_20110427T000000Z.nc -o $out_path/nexrad_3d_v4_2_20110427T000000Z.nc
#
# clean up
rm auth.rda.ucar.edu.$$ auth_status.rda.ucar.edu
