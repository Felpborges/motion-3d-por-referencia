#!/usr/bin/env bash
# Instala (ou atualiza) as duas skills na pasta de skills do Claude Code: motion-3d-por-referencia e referencia.
set -euo pipefail
ORIGEM="$(cd "$(dirname "$0")" && pwd)/skills"
DESTINO="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
mkdir -p "$DESTINO"
for s in motion-3d-por-referencia referencia; do
  rm -rf "$DESTINO/$s"                      # atualização limpa: troca a versão anterior inteira
  cp -R "$ORIGEM/$s" "$DESTINO/$s"
  echo "instalada: $DESTINO/$s"
done
echo
echo "Pronto. Abra uma conversa nova no Claude Code e digite /referencia (abre o Atlas) ou /motion-3d-por-referencia."
for f in node python3 ffmpeg; do command -v "$f" >/dev/null 2>&1 || echo "aviso: '$f' não encontrado; a skill precisa dele."; done
python3 -c "import numpy, PIL, scipy" 2>/dev/null || echo "aviso: faltam bibliotecas do Python. Rode: python3 -m pip install numpy pillow scipy"
