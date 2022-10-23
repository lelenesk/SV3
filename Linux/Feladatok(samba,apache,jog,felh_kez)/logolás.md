/var/log/kern.log 
/var/log/sys.log 

#cut-al,grep-el tail,head maniplulálni

#modernebb
systemctl


journalctl
journalctl -S yesterday (időmeghatározás)
journalctl --system (legfontosabb bejegyzések)
journalctl --user (aktulais felhasználó tevékenységei)
journalctl --disk-usage
journalctl -p1 (kritikus cuccok)