# web

Proyecto Astro que se despliega en Vercel. Hoy contiene la landing; aquí vivirán también el portal (magic link) y los endpoints de agentes.

```sh
pnpm install          # desde la raíz del monorepo
pnpm dev              # http://localhost:4321
pnpm build            # genera apps/web/dist
```

## Estructura

- `src/pages/index.astro`: arma la landing con las secciones de `src/components/`.
- `src/styles/global.css`: tokens de color (claro y oscuro), escala tipográfica y utilidades.
- `src/config.ts`: nombre, dominio y número de WhatsApp de soporte.
- Las fuentes se declaran en `astro.config.mjs` y se descargan en el build, así que no se cargan desde Google en el navegador.

## Vercel

Configurar **Root Directory** en `apps/web`. Vercel detecta pnpm por el `pnpm-lock.yaml` de la raíz.
