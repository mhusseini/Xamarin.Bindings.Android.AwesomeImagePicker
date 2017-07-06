if(-Not (Test-Path "nuget.exe")) { Invoke-WebRequest -Uri "https://nuget.org/nuget.exe" -OutFile "nuget.exe" }
$version = Invoke-WebRequest -Uri https://jitpack.io/api/builds/com.github.myinnos/AwesomeImagePicker/latestOk | 
    % { $_.Content } | 
    ConvertFrom-Json | 
    % {$_.version}
$url = "https://jitpack.io/com/github/myinnos/AwesomeImagePicker/$version/AwesomeImagePicker-$version.aar"
Invoke-WebRequest -Uri $url -OutFile "Jars/package-release.aar"

$assemblyInfo = ".\Properties\AssemblyInfo.cs"
$tmp = "$assemblyInfo.tmp"
$newVersion = 'AssemblyVersion("' + $version + '")'
$newFileVersion = 'AssemblyFileVersion("' + $version + '")'

get-content $assemblyInfo |
    %{$_ -replace 'AssemblyVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)', $newVersion } |
    %{$_ -replace 'AssemblyFileVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)', $newFileVersion } > $tmp
move-item $tmp $assemblyInfo -force

$nuspecFile = "package.nuspec"
$xml = [xml](Get-Content $nuspecFile)
$xml.package.metadata.version = $version
$xml.Save((Resolve-Path "$nuspecFile").Path)