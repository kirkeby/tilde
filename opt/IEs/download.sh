#!/bin/sh

set -e

for version in "$@"
do
    case ${version} in
        8)
            url="http://download.microsoft.com/download/B/7/2/B72085AE-0F04-4C6F-9182-BF1EE90F5273/Windows_7_IE9.part0{1.exe,2.rar,3.rar,4.rar,5.rar,6.rar,7.rar}"
        ;;

        9)
            url="http://download.microsoft.com/download/B/7/2/B72085AE-0F04-4C6F-9182-BF1EE90F5273/Windows_7_IE8.part0{1.exe,2.rar,3.rar,4.rar}"
        ;;

        10)
            wget -O 'Windows_8_IE10.iso' 'http://go.microsoft.com/fwlink/?LinkId=251533'
        ;;

        *)
            echo "Unknown IE version: ${version}"
            exit 1
            ;;
    esac

    wget ${url}
done
