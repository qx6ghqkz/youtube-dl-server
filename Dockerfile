#
# youtube-dl-server Dockerfile
#

FROM python:alpine

RUN apk add --no-cache \
  ffmpeg \
  tzdata

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt .
RUN apk --update-cache add --virtual build-dependencies gcc libc-dev make \
  && pip install --no-cache-dir -r requirements.txt \
  && apk del build-dependencies

COPY . .

ENV CONTAINER_PORT=8080

EXPOSE ${CONTAINER_PORT}

VOLUME ["/youtube-dl"]

CMD ["uvicorn", "youtube-dl-server:app", "--host", "0.0.0.0", "--port", "${CONTAINER_PORT}"]
