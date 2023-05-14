FROM rust:latest as builder
WORKDIR /app
COPY . .
RUN cargo build --release


FROM debian:buster-slim

WORKDIR /app

COPY --from=builder /app/target/release/UserAndAuthBackend .

ENV ROCKET_ADDRESS=0.0.0.0
EXPOSE 8000
CMD ["./UserAndAuthBackend"]