FROM ubuntu:22.10 AS builder
# Setup standard utils
RUN apt-get update && apt-get install -y unzip xz-utils git openssh-client curl && apt-get upgrade -y && rm -rf /var/cache/apt
# Setup flutter & configure web sdk
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter config --enable-web
# release build of web app
WORKDIR /usr/src/app
COPY . ./
RUN flutter pub get
RUN flutter build web

FROM nginx:1.23.3-alpine AS runtime
COPY --from=builder usr/src/app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]