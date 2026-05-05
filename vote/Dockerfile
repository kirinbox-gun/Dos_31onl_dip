# Этап 1: Сборка зависимостей
FROM python:3.11-slim AS builder

WORKDIR /app

# Копируем только список зависимостей, чтобы кэшировать этот слой
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Этап 2: Финальный образ
FROM python:3.11-slim

WORKDIR /app

# Копируем установленные пакеты из предыдущего этапа
COPY --from=builder /root/.local /root/.local
# Обновляем переменную PATH, чтобы Python видел установленные пакеты
ENV PATH=/root/.local/bin:$PATH

# Копируем исходный код приложения
COPY . .

# Открываем порт 80 ( Flask в этом приложении настроен на него)
EXPOSE 80

# Команда для запуска
CMD ["python", "app.py"]