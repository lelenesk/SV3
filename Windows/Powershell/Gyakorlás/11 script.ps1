Get-acl | Select-Object *
$egyacl = Get-acl
($egyacl).Access

Get-Acl | Get-Member

# Új könyvtár és hozzá 1 usernek full controll adása NTFS jogosultságként
New-Item -Type Directory -Path "C:\Peldashare"
$Acl = Get-Acl . # Acl objektum
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("Mentor5", "FullControl", "Allow") # Acl rule objektum (ACE)
$Acl.SetAccessRule($Ar) # Beállítjuk az új objektumot 
Set-Acl -Path "C:\Peldashare" -AclObject $Acl # Visszaírjuk a változást az eredeti Acl objektumba
$Acl | Set-Acl -Path "C:\Peldashare" # Ugyanaz pipe-al