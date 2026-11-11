#!/usr/bin/env bash
# Prepara el codespace: pnpm, opencode v2 y dependencias del workspace.
set -euo pipefail

OPENCODE_VERSION="2.2.7"

npm i -g "pnpm@12.16.1"

# opencode v2 no se publica en npm: opencode-ai sigue en 1.19.5.
# Descargamos la release oficial para tener el binario v2.
mkdir -p ~/.opencode/bin
cd /tmp
curl -fsSL -o opencode-v2.tar.gz \
  "https://github.com/anomalyco/opencode/releases/download/v${OPENCODE_VERSION}/opencode-linux-x64-baseline.tar.gz"
tar xzf opencode-v2.tar.gz
mv opencode ~/.opencode/bin/opencode2
chmod +x ~/.opencode/bin/opencode2
rm -f opencode-v2.tar.gz

# El servidor se arranca con 'opencode2 serve' (v2), no con el binario de npm.
cat >> ~/.bashrc <<'ALIAS'

# opencode v2 (release oficial); el de npm es v1 y no expone 'serve' igual.
alias opencode='~/.opencode/bin/opencode2'
ALIAS

cd /workspaces/facil-pago
pnpm install
