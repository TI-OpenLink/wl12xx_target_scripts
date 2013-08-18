#!/bin/sh           
ps | grep h[o]stapd2                  
output=`ps |grep h[o]stapd2`
set -- $output              
echo $1                     
kill $1