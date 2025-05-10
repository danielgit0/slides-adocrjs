#!/bin/sh

ln -sf /app/revealjs /app/output/revealjs

mkdir -p /app/output

# Generate initial presentation
asciidoctor-revealjs \
  -D /app/output \
  /app/src/presentation.adoc

mv /app/output/presentation.html /app/output/index.html

while inotifywait -r -e modify,move,create,delete /app/src; do
  asciidoctor-revealjs \
    -D /app/output \
    /app/src/presentation.adoc
  mv /app/output/presentation.html /app/output/index.html
done &

cd /app/output && live-server --port=8080 --host=0.0.0.0 --no-browser