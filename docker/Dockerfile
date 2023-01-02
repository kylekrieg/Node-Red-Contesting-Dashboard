FROM nodered/node-red as base
ARG QEMU_ARCH
USER root
RUN apk add sqlite grep
USER node-red
RUN curl -sL -o /data/settings.js https://raw.githubusercontent.com/radiosport-live/Node-Red-AutoScripts/master/settings.js 

RUN mkdir -p /data/projects/

RUN git clone https://github.com/kylekrieg/Node-Red-Contesting-Dashboard.git --quiet /data/projects/Node-Red-Contesting-Dashboard

COPY package.json .
RUN npm install --unsafe-perm --no-update-notifier --no-fund --omit=dev
# Copy package.json to the WORKDIR so npm builds all
# of your added nodes modules for Node-RED
COPY schema.db /data

# Copy _your_ Node-RED project files into place
# NOTE: This will only work if you DO NOT later mount /data as an external volume.
#       If you need to use an external volume for persistence then
#       copy your settings and flows files to that volume instead.

RUN cd /data/projects/Node-Red-Contesting-Dashboard && for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master `; do \
   git branch --track ${branch#remotes/origin/} $branch ; \
done

RUN sqlite3 /usr/src/node-red/qsos < /data/schema.db
COPY docker/.config.projects.json /data
COPY docker/.config.users.json /data
ENV NODE_RED_ENABLE_PROJECTS=true
HEALTHCHECK CMD curl http://localhost:1880/ || exit 1

LABEL org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.docker.dockerfile=".docker/Dockerfile" \
    org.label-schema.license="Apache-2.0" \
    org.label-schema.name="Node-RED-Contest-Dashboard" \
    org.label-schema.version=${BUILD_VERSION} \
    org.label-schema.description="Low-code programming for event-driven applications." \
    org.label-schema.url="https://github.com/kylekrieg/Node-Red-Contesting-Dashboard" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/kylekrieg/Node-Red-Contesting-Dashboard" \
    org.label-schema.arch=${QEMU_ARCH} \
    authors="Connor Dickey KD9LSV, Kyle Krieg AA0Z"

# You should add extra nodes via your package.json file but you can also add them here:
#WORKDIR /usr/src/node-red
#RUN npm install node-red-node-smooth

