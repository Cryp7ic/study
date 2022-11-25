Write-Host 'Hello, World!'
write 1,2,3
# PowerShell
# Kausta loomine
New-Item -Path 'test' -ItemType Directory
New-Item -Path 'test\test.txt' -ItemType File
# Sama saab teha ka nii:
# New-Item test\test.txt
Set-Content -Path 'test\test.txt' -Value 'Hello, World!'
Get-Content -Path 'test\test.txt' 
Select-Object 'test\test.txt' -First 1
Add-Content -Path 'test\test.txt' -Value 'Next line :)'
write -----------
New-Item -Path 'test2' -ItemType Directory
Copy-Item -Filter *.txt -Path 'test' -Recurse -Destination 'test2'
#Get-Content -Path 'test\test.txt'
#Remove-Item -Path 'test\test.txt'
# Saab ka ühe commandiga (Replitis ei tööta):
#Remove-Item -Path 'test' -Recurse
