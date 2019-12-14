FROM node:12.13-alpine AS base

WORKDIR /app

ENV PORT 8000
ENV NODE_ENV=development
ENV PATH=${PATH}:/app/node_modules/.bin

# install dep manager
RUN npm install -g yarn

# Install deps.
COPY package*.json /app/
COPY yarn.lock /app/
RUN yarn install

# main app
FROM base AS app

# copy source
COPY tsconfig.json /app/
COPY index.ts /app/
COPY ./simple-service /app/simple-service

# Run app.
ENTRYPOINT ["yarn", "run", "prod"]

# test suite
FROM base AS test

RUN yarn install --dev

# copy source
COPY index.ts /app/
COPY simple-service /app/simple-service
COPY tests /app/tests

ENTRYPOINT ["yarn", "run", "jest"]
