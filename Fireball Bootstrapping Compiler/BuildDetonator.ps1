function Get-ScriptDirectory {
    Split-Path -Parent $PSScriptRoot
}

$rootPath = Get-ScriptDirectory
$sourcePath = "$rootPath\Tools\Detonator"
$binPath = "$rootPath\Fireball Bootstrapping Compiler\bin\Debug"
$fbccPath = "$binPath\fbcc.exe"
$outputName = "det.exe"
$outputPath = $binPath

$sourceFiles = dir -Path $sourcePath -Filter "*.fb" -Recurse

echo ""
echo "========================================================"

echo "Compiling:"
foreach($f in $sourceFiles) {
    echo $f.fullname.Replace("$sourcePath\", "")
}

echo ""

$sourceFilesArg = ( $sourceFiles | % { $_.FullName } )

$cmdArgs = @("-nowarn:10003,168", "-out:""$outputPath\$outputName""") + $sourceFilesArg
&"$fbccPath" $cmdArgs