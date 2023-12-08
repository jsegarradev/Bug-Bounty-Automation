#!/bin/bash

domain=$1
use_xray=$2

mkdir ~/BB/$domain
mkdir ~/BB/$domain/xray

# Collect subdomains
subfinder -d $domain -silent | anew ~/BB/$domain/subs.txt
assetfinder -subs-only $domain | anew ~/BB/$domain/subs.txt

# Check for alive subdomains
cat ~/BB/$domain/subs.txt | httpx -silent | anew ~/BB/$domain/alive.txt

# Test by Xray if specified
if [ "$use_xray" == "--xray" ]; then
    for i in $(cat ~/BB/$domain/alive.txt); do
        xray_linux_amd64 ws --basic-crawler $i --plugins xss,sqldet,xxe,ssrf,cmd-injection,path-traversal --ho $(date +"%T").html
    done
fi

# Test for nuclei
cat ~/BB/$domain/alive.txt | nuclei -t ~/cent-nuclei-templates -es info,unknown -etags ssl,network | anew ~/BB/$domain/nuclei.txt
