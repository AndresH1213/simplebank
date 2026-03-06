# Build stage
FROM golang:1.25.0-alpine AS builder

WORKDIR /app

COPY . .

RUN go build -o main main.go
RUN apk add curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.19.1/migrate.linux-amd64.tar.gz | tar xvz


FROM alpine:3.22
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/migrate ./migrate
COPY --from=builder /app/app.env .
COPY --from=builder /app/db/migration ./migration
COPY --from=builder /app/startup.sh .

EXPOSE 8080
CMD ["/app/main"]
ENTRYPOINT ["/app/startup.sh"]