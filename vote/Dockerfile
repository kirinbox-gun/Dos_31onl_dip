# 1 сборка зависимостей
FROM python:3.11-slim AS builder

WORKDIR /app

# копирую только список зависимостей, чтобы кэшировать этот слой
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# 2 финальный образ
FROM python:3.11-slim

WORKDIR /app

# копирую установленные пакеты из предыдущего этапа
COPY --from=builder /root/.local /root/.local
# обновляю переменную PATH, чтобы Python видел установленные пакеты
ENV PATH=/root/.local/bin:$PATH

COPY . .

# открываю 80 (Flask в этом приложении настроен на него)
EXPOSE 80

# для запуска
CMD ["python", "app.py"]