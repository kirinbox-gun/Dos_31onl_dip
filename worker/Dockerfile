# ЭТАП 1: Сборка (используем SDK)
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS builder

WORKDIR /source

# Копируем файл проекта и восстанавливаем зависимости (аналог npm install)
COPY *.csproj .
RUN dotnet restore

# Копируем остальной код и компилируем (публикуем) приложение
COPY . .
RUN dotnet publish -c Release -o /app --no-restore

# ЭТАП 2: Финальный образ (используем легкий Runtime)
FROM mcr.microsoft.com/dotnet/runtime:7.0

WORKDIR /app

# Забираем из первого этапа ТОЛЬКО готовое скомпилированное приложение
COPY --from=builder /app .

# У .NET приложений нет стандартного порта для прослушивания в этом проекте, 
# так как это фоновый воркер, который просто перекладывает данные из Redis в Postgres.

CMD ["dotnet", "Worker.dll"]
