const puppeteer = require('puppeteer');
const fs = require('fs');

(async () => {
  const htmlContent = `
    <html>
    <head>
      <title>Ejemplo PDF</title>
    </head>
    <body>
      <h1>Hola, este es un ejemplo en PDF generado por Puppeteer</h1>
    </body>
    </html>
  `;

  // Lanza el navegador en modo headless
  const browser = await puppeteer.launch({ headless: true, args: ['--no-sandbox', '--disable-setuid-sandbox'] });
  const page = await browser.newPage();

  // Configura el contenido HTML y genera el PDF
  await page.setContent(htmlContent, { waitUntil: 'networkidle0' });
  const pdfBuffer = await page.pdf({ format: 'A4' });

  // Convierte el PDF a base64 y almacénalo en una variable
  const pdfBase64 = pdfBuffer.toString('base64');

  // Guarda el Base64 en un archivo de texto para verificar
//   fs.writeFileSync('pdfBase64.txt', pdfBase64, 'utf-8');

console.log(Buffer.from(pdfBuffer).toString('base64'));


//   console.log('PDF en base64 guardado en pdfBase64.txt');

  await browser.close();
})();
