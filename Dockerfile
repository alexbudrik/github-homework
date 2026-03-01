FROM alpine:latest
RUN apk add --no-cache bash
COPY app.sh /app.sh
RUN chmod +x /app.sh
CMD ["/app.sh"]
