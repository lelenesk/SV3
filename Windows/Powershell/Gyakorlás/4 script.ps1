# Környezeti változók powershellben
# Felhasználó szintű
# Új érték
$env:valamivaltozo = "valamiérték"
# Meglévő bővÍtése pl path
$env:Path += ";C:\aa"

# Rendszer szintű (.net objektumrendszer használatával)
[System.Environment]::SetEnvironmentVariable('valamivaltozo','valamiérték')

# https://www.tutorialspoint.com/how-to-set-environment-variables-using-powershel