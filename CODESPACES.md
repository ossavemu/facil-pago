# Facil Pago — Codespaces

Arbol de trabajo remoto para `ossavemu/facil-pago` sin clonar el repo en el PC.

## Que hay montado

- **Codespace**: `animated-space-goggles-5p57qj974j4h7gxp` (Debian 13, Node 24.22.1, pnpm 12.16.1).
- **Repo**: `/workspaces/facil-pago` dentro del codespace.
- **Agente**: opencode v2.2.7 corriendo en el codespace (`opencode serve --hostname 0.0.0.0 --port 4096`).
- **Tunel desde el PC**: `ssh -N -L 4096:localhost:4096 cs.animated-space-goggles-5p57qj974j4h7gxp.fix-devcontainer-imagen`.
- **Cliente**: `opencode --server http://localhost:4096` (password en `OPENCODE_PASSWORD`).

## Conectar

```sh
export OPENCODE_PASSWORD="facilpago-codespace-2026"

# abrir el tunel (dejarlo corriendo)
ssh -N -L 4096:localhost:4096 cs.animated-space-goggles-5p57qj974j4h7gxp.fix-devcontainer-imagen

# conectar el agente
opencode --server http://localhost:4096
```

Desde el navegador: `opencode pair` y abrir el link.

## Validacion

El CI corre en los runners de GitHub, sin maquina local:

```sh
gh pr checks <n> --repo ossavemu/facil-pago
```

Hace `pnpm install --frozen-lockfile`, `astro check` y `pnpm build` sobre `apps/web`.

## Desarrollo dentro del codespace

```sh
ssh cs.animated-space-goggles-5p57qj974j4h7gxp.fix-devcontainer-imagen
cd /workspaces/facil-pago
pnpm dev          # astro dev en 4321
pnpm build
```

## Notas

- La imagen es `mcr.microsoft.com/devcontainers/typescript-node:24` porque la feature `node`
  necesita `apt` y el runner no resolvia `archive.ubuntu.com` durante el build.
- `opencode` V2 no se instala por npm (npm `opencode-ai` sigue en 1.19.5). Se descarga la release
  v2.2.7 de GitHub y queda en `~/.opencode/bin/opencode2`.
- La credencial de OpenRouter se registra en el servidor con
  `POST /api/integration/openrouter/connect/key` (V2 la guarda en su DB SQLite, no en `auth.json`).
