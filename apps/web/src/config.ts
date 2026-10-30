// Datos públicos de la marca. Reemplazar el número cuando exista la línea de SOPORTE.
export const SITE = {
  name: 'Fácil Pago',
  url: 'https://facilpago.co',
  description:
    'Inventario, ventas y comprobantes para tiendas de barrio, todo por WhatsApp. Vende con una foto, un audio o un mensaje.',
  // Formato internacional sin "+" ni espacios, como lo pide wa.me
  whatsappSoporte: '573000000000',
  repo: 'https://github.com/ossavemu/facil-pago',
} as const;

export const waLink = (text: string) =>
  `https://wa.me/${SITE.whatsappSoporte}?text=${encodeURIComponent(text)}`;
