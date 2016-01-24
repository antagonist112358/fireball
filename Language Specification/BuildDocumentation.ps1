$compiler = "..\Packages\CommonMark.NET.0.11.0\tools\cmark.exe"
$specs = Get-ChildItem | where {$_.extension -eq ".md" }
"Compiling Documentation..."

ForEach($doc in $specs) {
    $outPath = Split-Path $doc.FullName
    $outFile = $outPath + "\Compiled\" + $doc.BaseName + ".html"
    $outFile

    $filename = $doc.FullName
    "Running: cmark.exe $filename --out $outFile"
    & $compiler @($filename, '--out', $outFile)

}

"Finished!"