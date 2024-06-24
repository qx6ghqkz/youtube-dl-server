#!/bin/sh
exec uvicorn youtube-dl-server:app --host 0.0.0.0 --port ${CONTAINER_PORT}
