FROM rust:latest as builder

WORKDIR /app

COPY . .

RUN cargo build --release

FROM debian:buster-slim

WORKDIR /app

RUN apt-get update && apt-get install -y libpq5

COPY --from=builder /app/target/release/UserAndAuthBackend .
COPY ../.env .

ENV ROCKET_ADDRESS=0.0.0.0

CMD ["./UserAndAuthBackend"]

EXPOSE 8000