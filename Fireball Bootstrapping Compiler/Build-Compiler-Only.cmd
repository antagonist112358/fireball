@echo Starting MS-BUILD for Fireball Compiler...
@echo ==========================================================================================================
set MSBuild="%SystemRoot%\Microsoft.NET\Framework\v4.0.30319\msbuild.exe"
set NoPause=true
%MSBuild% Fireball.Compiler.nproj /p:Configuration=Debug /verbosity:n /p:NTargetName=Build /tv:4.0 /p:TargetFrameworkVersion=v4.0
@echo     