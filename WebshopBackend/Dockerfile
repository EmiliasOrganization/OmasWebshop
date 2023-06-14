FROM ghcr.io/graalvm/graalvm-ce:ol8-java17-22.3.2 as builder

WORKDIR /builder

COPY ./WebshopBackend .

RUN microdnf install maven -y

RUN mvn -Pnative clean native:compile -DskipTests

FROM oraclelinux:9-slim

COPY ../.env .

WORKDIR /app

COPY --from=builder /builder/target/webshopBackend /app

CMD ./webshopBackend