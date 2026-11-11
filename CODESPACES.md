# Facil Pago — Codespaces

Arbol de trabajo remoto para `ossavemu/facil-pago` sin clonar el repo en el PC.

## Que hay montado

- **Codespace**: Debian 13, Node 24, pnpm 12.16.1, opencode v2.2.7.
- **Repo**: `/workspaces/facil-pago` dentro del codespace.
- **Agente**: `opencode serve` escuchando en el puerto 4096 del codespace.
- **Tunel**: un `ssh -L` desde el PC al puerto 4096 del codespace.

## Conectar

### 1. Crear o elegir codespace

```sh
# crear uno nuevo
gh codespace create -R ossavemu/facil-pago

# ver los tuyos y su estado
gh codespace list -R ossavemu/facil-pago
```

Anota el **nombre** del codespace que vas a usar (por ejemplo `glorious-chainsaw-v7wjv95jwr5369pr`).
Cada codespace tiene el suyo: no reutilices el nombre de otro.

### 2. Levantar el servidor opencode dentro del codespace

El servidor necesita una contraseña. **Eligela tu y no la guardes en el repo**:
este archivo es publico, asi que una clave escrita aqui queda expuesta.

```sh
ssh <NOMBRE_DEL_CODESPACE> \
  "export OPENCODE_PASSWORD='<TU_CONTRASENA>' && \
   cd /workspaces/facil-pago && \
   setsid ~/.opencode/bin/opencode2 serve --hostname 0.0.0.0 --port 4096 \
     > /tmp/oc2.log 2>&1 < /dev/null &"
```

### 3. Abrir el tunel desde el PC

```sh
ssh -N -L 4096:localhost:4096 <NOMBRE_DEL_CODESPACE>
```

El tunel queda escuchando en `localhost:4096` de este Mac.

### 4. Conectar el cliente

```sh
export OPENCODE_PASSWORD='<LA_MISMA_CONTRASENA>'
opencode --server http://localhost:4096
```

El cliente pide la misma contrasena que le diste al servidor en el paso 2.

Desde el navegador: `opencode pair` y abrir el link.

## Validacion

El CI corre en los runners de GitHub, sin maquina local:

```sh
gh pr checks <n> --repo ossavemu/facil-pago
```

Hace `pnpm install --frozen-lockfile`, `astro check` y `pnpm build` sobre `apps/web`.

## Desarrollo dentro del codespace

```sh
ssh <NOMBRE_DEL_CODESPACE>
cd /workspaces/facil-pago
pnpm dev          # astro dev en 4321
pnpm build
```

## Notas

- La imagen es `mcr.microsoft.com/devcontainers/typescript-node:24` porque la feature `node`
  necesita `apt` y el runner no resolvia `archive.ubuntu.com` durante el build.
- `opencode` V2 no se instala por npm: el paquete `opencode-ai` sigue en 1.19.5. La release v2.2.7
  se descarga de GitHub y queda en `~/.opencode/bin/opencode2`. El `postCreateCommand` del
  devcontainer instala la version de npm, asi que hay que reemplazar el binario por la release:

  ```sh
  cd /tmp && \
    curl -fsSL -o oc2.tar.gz \
      https://github.com/anomalyco/opencode/releases/download/v2.2.7/opencode-linux-x64-baseline.tar.gz && \
    tar xzf oc2.tar.gz && mv opencode ~/.opencode/bin/opencode2
  ```

- La credencial de OpenRouter se registra en el servidor con
  `POST /api/integration/openrouter/connect/key` (V2 la guarda en su DB SQLite, no en `auth.json`).
