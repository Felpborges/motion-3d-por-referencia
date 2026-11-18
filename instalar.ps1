# Instala (ou atualiza) as duas skills na pasta de skills do Claude Code: motion-3d-por-referencia e referencia.
# Uso:  powershell -ExecutionPolicy Bypass -File instalar.ps1      (ou dois cliques em instalar.bat)
$ErrorActionPreference = "Stop"
$origem = Join-Path $PSScriptRoot "skills"
$destino = if ($env:CLAUDE_SKILLS_DIR) { $env:CLAUDE_SKILLS_DIR } else { Join-Path $env:USERPROFILE ".claude\skills" }
New-Item -ItemType Directory -Force -Path $destino | Out-Null
foreach ($s in @("motion-3d-por-referencia", "referencia")) {
  $alvo = Join-Path $destino $s
  if (Test-Path $alvo) { Remove-Item -Recurse -Force $alvo }      # atualizacao limpa: troca a versao anterior inteira
  Copy-Item -Recurse -Path (Join-Path $origem $s) -Destination $alvo
  Write-Host "instalada: $alvo"
}
Write-Host ""
Write-Host "Pronto. Abra uma conversa nova no Claude Code e digite /referencia (abre o Atlas) ou /motion-3d-por-referencia."
foreach ($f in @("node", "ffmpeg")) {
  if (-not (Get-Command $f -ErrorAction SilentlyContinue)) { Write-Host "aviso: '$f' nao encontrado; a skill precisa dele." }
}
$py = @("python", "py", "python3") | Where-Object { Get-Command $_ -ErrorAction SilentlyContinue } | Select-Object -First 1
if (-not $py) { Write-Host "aviso: Python nao encontrado; a skill precisa dele (winget install Python.Python.3.12)." }
else {
  & $py -c "import numpy, PIL, scipy" 2>$null
  if ($LASTEXITCODE -ne 0) { Write-Host "aviso: faltam bibliotecas do Python. Rode: $py -m pip install numpy pillow scipy" }
}
