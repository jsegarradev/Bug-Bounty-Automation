#!/bin/bash 

domain=$1
mkdir ~/BB/$1
mkdir ~/BB/$1/xray

subfinder -d $1 -silent | anew ~/BB/$1/subs.txt
assetfinder -subs-only $1 | anew ~/BB/$1/subs.txt

                                                                                                                                                                                                             
cat ~/BB/$1/subs.txt | httpx -silent | anew ~/BB/$1/alive.txt              
                                                                                                                                                                                                                                        >

## Test by Xray 

## for i in $(cat /home/kali/BB/$1/alive.txt); do xray_linux_amd64 ws --basic-crawler $i --plugins xss,sqldet,xxe,ssrf,cmd-injection,path-traversal --ho $(date +"%T").html ; done 
  

## test for nuclei 

cat ~/BB/$1/alive.txt | nuclei -t ~/cent-nuclei-templates -es info,unknown -etags ssl,network | anew ~/BB/$1/nuclei.txt

