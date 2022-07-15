"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" createvm --name "WS2019-BAT" --ostype "Windows2019_64" --register
REM UID: ce6857a5-1e01-413c-8bf3-aea3c8aaa2b6

"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" createmedium disk --filename "D:\temp\S2019-BAT.vdi" --size 32768
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"  storagectl "WS2019-BAT" --name "SATA Controller" --add sata --controller IntelAHCI
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"  storageattach "WS2019-BAT" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "D:\temp\S2019-BAT.vdi"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"  storagectl "WS2019-BAT" --name "IDE Controller" --add ide
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"  storageattach "WS2019-BAT" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "D:\DevEnv\WORK\repository\iso\windows2019\17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"


"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyvm "WS2019-BAT" --ioapic on
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyvm "WS2019-BAT" --boot1 dvd --boot2 disk --boot3 none --boot4 none
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyvm "WS2019-BAT" --memory 8192 --vram 128

"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" unattended install "WS2019-BAT" --iso="D:\DevEnv\WORK\repository\iso\windows2019\17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso" --script-template="D:\DevEnv\WORK\packer\mywindows2019\scripts\Autounattend.xml"

"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm "WS2019-BAT" --type headless