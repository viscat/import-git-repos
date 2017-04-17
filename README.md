# import-git-repos
Simple bash script to download and pack git repositories

## How to use it
Create a txt file with a list of projects you want to import

Then call the script
```bash
./import-projects.sh projects.txt
```

This will clone all projects defined in `projects.txt` into projects directory 
(in the current directory). If some of the repositories alredy exist, it will
pull it instead of clone it. When finishes importing all projects, it will also
create a projects.tar.gz file.
