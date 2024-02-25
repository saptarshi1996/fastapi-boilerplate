# Build stage
FROM python:3.9.6-alpine as build
WORKDIR /app
COPY . .
RUN apk update && apk add binutils
RUN pip3 install -r requirements.txt
RUN pip3 install pyinstaller
RUN pyinstaller --onefile --noconfirm --distpath dist/dist --specpath dist/specs --workpath dist/build server.py

# Runtime environment
FROM alpine:latest AS runtime

WORKDIR /app
COPY --from=build /app/dist/dist/server /app/server
EXPOSE 8081
CMD ["./server"]
