# Motion 3D por referência

Skill do Claude Code que cria motion graphics 3D **só com código** (three.js), a partir de um vídeo ou de uma imagem
de referência, de um estilo pronto do Atlas, ou do zero. Vem com o **Atlas**: 18 motions aprovados, cada um com a
prévia em vídeo, o método e o código.

## Instalar

No Terminal (Mac ou Linux):

```bash
git clone --depth 1 https://github.com/Felpborges/motion-3d-por-referencia.git /tmp/motion-3d && bash /tmp/motion-3d/instalar.sh
```

No Windows, ou sem git: baixe o repositório (botão **Code → Download ZIP**), descompacte e copie as duas pastas de
dentro de `skills/` (`motion-3d-por-referencia` e `referencia`) para a pasta de skills do Claude Code
(`~/.claude/skills` no Mac e no Linux, `%USERPROFILE%\.claude\skills` no Windows).

Depois, abra uma conversa nova no Claude Code.

### O que precisa estar instalado

Node, Python 3 (com `numpy`, `pillow` e `scipy`), ffmpeg e o Google Chrome. Para baixar referência por link,
também o `yt-dlp`.

## Usar

| Comando | O que faz |
|---|---|
| `/referencia` | Abre o Atlas no navegador. Escolha um estilo, escreva o seu tema, clique em **Usar este estilo** e cole no Claude. |
| `/motion-3d-por-referencia` | Cria o motion. Mande junto a sua referência (vídeo, link ou imagem) e o que você quer; ou descreva o que quer criar do zero. |

Exemplos de pedido:

- `/motion-3d-por-referencia` + um vídeo: "quero um motion bem próximo desse, mas do meu produto, vertical, 10 s"
- `/motion-3d-por-referencia` + uma imagem: "anima essa imagem em 3D"
- `/motion-3d-por-referencia atlas:18 (Fone explodido). Meu tema: o que tem dentro de uma garrafa térmica`

O Atlas é opcional: quem tem a própria referência ou quer criar do zero não precisa abrir.

## Como a skill trabalha

1. **Mede a referência** em segundos: câmera, luz, cor, proporções, foco e ritmo.
2. **Decide o porte.** Cena simples é feita direto. Cena com vários objetos é dividida: cada objeto é construído
   isolado e revisado em quatro vistas, em paralelo, enquanto a cena e a animação avançam com blocos provisórios.
3. **Renderiza** quadro a quadro no Chrome sem janela e junta com o ffmpeg, com cor correta no arquivo final.
4. **Confere** o resultado contra a referência (ritmo e cor) e diz o que bate, o que não bate e o que não foi
   verificado.

O resultado é uma cena estilizada em tempo real, não vídeo fotorrealista.

## O que tem aqui

```
skills/motion-3d-por-referencia/    a skill: instruções, ferramentas, modelo de projeto e o Atlas
  atlas/                            os 18 motions (galeria, método, código e prévia de cada um)
  assets/template/                  o modelo de projeto three.js
  scripts/                          medição da referência, câmera, comparação, banco de peças
  references/                       regras de three.js, receitas por estilo, revisão
skills/referencia/                  o comando /referencia
instalar.sh                         copia as duas pastas para ~/.claude/skills
```

## Avisos

- Marcas e logotipos que aparecem em alguns exemplos do Atlas pertencem aos seus donos e estão ali só como exemplo.
- As referências que inspiraram cada estilo estão citadas no método de cada motion; os arquivos delas não fazem
  parte deste repositório.
