# vim: set ft=make :

# Adds a script in Steam to boot Windows which is useful for dual-boot setups
setup-boot-windows-steam:
    #!/usr/bin/bash

    echo "Making ~/boot-windows.sh script"
    echo "#!/usr/bin/bash" | tee ~/boot-windows.sh
    echo 'boot_number=$(echo $(efibootmgr) | grep -Po "(?<=Boot)\S{4}(?=( |\* )Windows)")' | tee -a ~/boot-windows.sh
    echo 'sudo efibootmgr -n "${boot_number}" && reboot' | tee -a ~/boot-windows.sh
    chmod +x ~/boot-windows.sh

    echo "Making efibootmgr -n accessible without sudo"
    echo "%wheel ALL=(root) NOPASSWD: /usr/sbin/efibootmgr" | sudo tee /etc/sudoers.d/efibootmgr-config

    echo "Adding ~/boot-windows.sh as a Non-steam game"
    /usr/bin/steamos-add-to-steam ~/boot-windows.sh
