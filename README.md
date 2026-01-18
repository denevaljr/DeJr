# Psyche Voice Assistant (Streaming) + One‑Click Builder

Você pediu "tudo automatizado". O que dá para fazer de forma **realista** no Windows é:
- você **não instala nada manualmente** (pip, pyinstaller etc),
- você só **clica/dá duplo clique** num script,
- e ele faz: venv -> deps -> build do EXE.

⚠️ Limite físico:
Sem **nenhum** download externo é impossível, porque o próprio Python e as bibliotecas precisam vir de algum lugar.
Para ficar **100% offline**, você precisa primeiro gerar um "wheelhouse" (pasta com as dependências) uma vez.
Eu incluí dois modos:

## Modo A (online, 1 clique)
- Baixa dependências automaticamente do PyPI.
- Requer internet.

Duplo clique em: `ONE_CLICK_BUILD.cmd`

## Modo B (offline, 1 clique)
1) Em um PC com internet (uma vez), rode:
   `builder\PREPARE_OFFLINE_WHEELHOUSE.cmd`
   Isso cria `wheelhouse\` com tudo.
2) Depois, em qualquer PC (mesmo sem internet), duplo clique em:
   `ONE_CLICK_BUILD_OFFLINE.cmd`

## Resultado
O executável sai em:
`dist\PsycheVoiceAssistant\PsycheVoiceAssistant.exe`

## API Key
Crie `.env` na raiz:
PSYCHE_API_KEY=SUA_KEY_AQUI
PSYCHE_ENDPOINT=https://api.psyche.ai/chat
