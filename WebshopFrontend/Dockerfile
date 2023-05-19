FROM ubuntu:22.10 AS builder

RUN apt-get update && \
    apt-get install -y unzip xz-utils git openssh-client curl && \
    apt-get upgrade -y && \
    rm -rf /var/cache/apt && \
    git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter config --enable-web

WORKDIR /usr/src/app
COPY . ./

RUN flutter pub get && flutter build web

FROM nginx:1.23.3-alpine AS runtime
COPY --from=builder usr/src/app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80