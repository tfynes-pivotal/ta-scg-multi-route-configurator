#!/bin/bash

if [ "$#" -ne 1 ] ;
  then
     echo "Usage wait-for-service-delete.sh [service-name]"
     exit 1
fi

echo Waiting for $1 to delete
while true; do
      status=`cf service $1 | grep -i "status"`
      if [[ $status == *"delete in progress"* ]]
      then
	      echo -n "-"
      else
              echo "done"
              sleep 1
              break
      fi
done