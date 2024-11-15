# Usa una imagen de Node como base
FROM node:20-slim

# Instala dependencias adicionales para Puppeteer
RUN apt-get update && \
    apt-get install -y \
        libx11-xcb1 \
        libxcomposite1 \
        libxdamage1 \
        libxi6 \
        libxtst6 \
        libnss3 \
        libxrandr2 \
        libasound2 \
        libpangocairo-1.0-0 \
        libatk1.0-0 \
        libcups2 \
        libdrm2 \
        libgbm1 \
        libxshmfence1 \
        wget \
        xdg-utils \
        fonts-liberation \
        libpango1.0-0 \
        libatk-bridge2.0-0 \
        libgtk-3-0 \
        libx11-6 \
        libx11-xcb-dev && \
    rm -rf /var/lib/apt/lists/*

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos del proyecto
COPY package*.json ./

# Instala las dependencias de Node.js
RUN npm install

# Configura Puppeteer para que no descargue Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# Copia el resto de los archivos del proyecto
COPY . .

# Comando para ejecutar el archivo
CMD ["node", "index.js"]
