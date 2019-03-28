FROM stefanscherer/node-windows as builder

COPY bin bin
COPY src src
COPY .babelrc .babelrc
COPY .eslintrc.json .eslintrc.json
COPY package.json package.json
COPY package-lock.json package-lock.json

RUN npm install
RUN npm run build

COPY boot.cmd boot.cmd

FROM builder

COPY --from=builder nodejs nodejs
COPY --from=builder node_modules node_modules
COPY --from=builder lib lib

ENTRYPOINT [ "boot.cmd" ]