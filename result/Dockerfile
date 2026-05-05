# Этап 1: Сборка зависимостей
FROM node:18-slim AS builder

WORKDIR /app

# Копируем файлы со списком библиотек
COPY package*.json ./

# Устанавливаем библиотеки (аналог pip install)
RUN npm install

# Этап 2: Финальный образ
FROM node:18-slim

WORKDIR /app

# Копируем только папку с установленными библиотеками из первого этапа
COPY --from=builder /app/node_modules ./node_modules

# Копируем весь остальной код приложения
COPY . .

EXPOSE 80

# Запуск приложения через node (в папке result основной файл называется server.js)
CMD ["node", "server.js"]