#!/bin/bash

if [ "$#" -ne 1 ] ;
  then
     echo "Usage waitForServiceCreate.sh [service-name]"
     exit 1
fi


while true; do
      status=`cf service $1 | grep -i "status"`
      if [[ $status == *"create in progress"* ]]
      then
	      echo -n "."
      else
              echo "done"
              break
      fi
done
