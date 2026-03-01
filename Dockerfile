FROM alpine:latest

# Установим bash
RUN apk add --no-cache bash

# Копируем скрипт приложения внутрь контейнера
COPY app.sh /app.sh
RUN chmod +x /app.sh

CMD ["/app.sh"]
