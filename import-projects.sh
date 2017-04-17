#!/bin/bash


if [ ! $# -eq 1 ]; then
  echo "You must specify a file with projects to import" >> /dev/stderr
  exit 1
fi

file=$1
regex="\/([^\.\/]+).git$"

if [ ! -d "projects" ]; then
  mkdir projects
fi

while IFS= read line
do
    if [[ $line =~ $regex ]]
    then
        name="${BASH_REMATCH[1]}"
        if [ -d projects/$name ]; then
          echo -e "\e[1;33m~ \e[1;39mPulling changes for \e[32m\"$name\"\e[0m ..."
          cd projects/$name && git pull origin master -q && cd ../..
        else
           echo -e "\e[1;32m+ \e[1;39mImporting \e[32m\"$name\"\e[0m ..."
           git clone $line projects/$name -q
        fi
    else
        if [ ! -z $line ]; then
          echo "$line doesn't match" >&2 
        fi
    fi
done <"$file"

echo -e "\e[1mCompressing projects into \e[32mprojects.tar.gz\e[39m ...\e[0m"
tar -czf projects.tar.gz projects
size=`du -h projects.tar.gz | cut -f 1`
echo -e "\e[1mCompressed size: \e[32m$size"
