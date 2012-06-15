#!/bin/sh

set -e

ga_iso="/usr/share/virtualbox/VBoxGuestAdditions.iso"

for version in "$@"
do
    vm=IE${version}
    vm_type=Windows7
    vm_path="$HOME/VirtualBox VMs/${vm}"
    archive="Windows_7_${vm}.part01.exe"

    case ${version} in
        8) vhd="Win7_IE8.vhd" ;;
        9) vhd="Windows 7.vhd" ;;
        *)
            echo "Unknown IE version: ${version}"
            exit 1
            ;;
    esac

    mkdir -p "${vm_path}/"
    cd "${vm_path}/"
    unrar e "${OLDPWD}/${archive}"

    VBoxManage createvm --name "${vm}" --ostype "${vm_type}" --register
    VBoxManage modifyvm "${vm}" --memory 1024 --vram 64
    VBoxManage storagectl "${vm}" --name "IDE Controller" \
                --add ide --controller PIIX4 --bootable on
    VBoxManage internalcommands sethduuid "${vm_path}/${vhd}"
    VBoxManage storageattach "${vm}" --storagectl "IDE Controller" \
                --port 0 --device 0 --type hdd --medium "${vm_path}/${vhd}"
    VBoxManage storageattach "${vm}" --storagectl "IDE Controller" \
                --port 0 --device 1 --type dvddrive --medium "${ga_iso}"
    VBoxManage snapshot "${vm}" take clean \
                --description "The initial VM state"
done
