FROM node:alpine
LABEL maintainer=alex.e.hatfield@gmail.com

WORKDIR /root/noVNC

ENV HOME=/root \
	DEBIAN_FRONTEND=noninteractive \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=C.UTF-8 \
	REMOTE_HOST=localhost \
	REMOTE_PORT=5900

RUN apk --update --upgrade add git bash python3 \
    && git clone https://github.com/novnc/noVNC ./ \
	&& git clone https://github.com/novnc/websockify ./utils/websockify \
	&& rm -rf .git \
	&& rm -rf utils/websockify/.git \
	&& npm install \
	&& apk del git

COPY noVNC/ /root/noVNC/

EXPOSE 8081

CMD ./utils/novnc_proxy --vnc "$REMOTE_HOST:$REMOTE_PORT" --listen 8081 --web /root/noVNC/
