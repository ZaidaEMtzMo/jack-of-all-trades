# jack-of-all-trades
A combination of standalone scripts with multiple purposes.

-**print.sh:**
      Script to print from linux systems, using `lp` and the McGill Uprint system. To use it, you only need to:
1. Add your short username inside the script (line 8).
2. Give the file rights. To do so, go to the directory where the file was downloaded and write:  `chmod u+x print.sh`
3. For easy access, add an entry in your .bash_aliases file:

  `cd`
  
  `nano .bash_aliases`
  
  `alias print_file='bash write-location-of-print.sh-here'`
