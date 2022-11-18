# 1. Loob töölauda kausta teie nimega
# 2. Loob kausta sisse uue faili (nimeks panna tänase kuupäeva abiks get-date)
New-Item -Path 'C:\Users\opilane\Desktop\thomas' -ItemType Directory
$filename = $(Get-Date -f "MM_dd_yyyy")

New-Item -Path C:\Users\opilane\Desktop\thomas\$($filename)

Add-Content -Path C:\Users\opilane\Desktop\thomas\$($filename) -Value 'Tere!', 'tekst'

Get-Content -Path C:\Users\opilane\Desktop\thomas\$($filename)

Add-Content -Path C:\Users\opilane\Desktop\thomas\$($filename) -Value 'kolmas'

Get-Content -Path C:\Users\opilane\Desktop\thomas\$($filename)

Rename-Item -Path C:\Users\opilane\Desktop\thomas\$($filename) -NewName 'uus_nimi'
#$filename = $('uus_nimi.txt')
#Rename-Item -Path C:\Users\opilane\Desktop\thomas\$($filename) -NewName $($filename)

New-Item -Path C:\Users\opilane\Desktop\thomas\backup -ItemType Directory

Copy-Item -Path C:\Users\opilane\Desktop\thomas\uus_nimi -Destination C:\Users\opilane\Desktop\thomas\backup\