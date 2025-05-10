FROM ruby:3.2-alpine

WORKDIR /app

ENV PUPPETEER_SKIP_DOWNLOAD=true

RUN apk add --no-cache \
    build-base \
    git \
    nodejs \
    npm \
    inotify-tools \
    python3

RUN gem install \
    asciidoctor:2.0.23 \
    asciidoctor-revealjs:5.2.0

RUN npm install -g live-server

RUN git clone https://github.com/hakimel/reveal.js.git --depth 1 --branch 5.2.1 revealjs \
    && cd revealjs \
    && npm install --no-audit --no-fund --unsafe-perm

RUN mkdir -p /app/src /app/output

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /app/src

EXPOSE 8080

# Allow symlink creation
RUN chmod -R a+rw /app

ENTRYPOINT ["/entrypoint.sh"]