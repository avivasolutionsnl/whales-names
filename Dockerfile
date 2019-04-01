FROM stefanscherer/node-windows as builder

COPY bin bin
COPY src src
COPY .babelrc .babelrc
COPY .eslintrc.json .eslintrc.json
COPY package.json package.json
COPY package-lock.json package-lock.json

RUN npm install
RUN npm run build
RUN npm prune --production

FROM stefanscherer/node-windows:pure

COPY --from=builder node_modules node_modules
COPY --from=builder lib lib
COPY boot.cmd boot.cmd

ENTRYPOINT [ "boot.cmd" ]