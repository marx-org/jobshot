# Use official Node.js 22 LTS image for compatibility with Vite plugin
# syntax=docker/dockerfile:1

FROM ghcr.io/marx-org/base-node:22-alpine@sha256:a3d3cea2575a542fe6f3d0b931f214027870ddf2cbcef488fc60b913c8f9c40d

ARG APP_VERSION=""
LABEL org.opencontainers.image.version="${APP_VERSION}"

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy source files
COPY . .

# Build React UI
RUN yarn build

# Expose port (default 3000)
EXPOSE 3000

# Start the backend (serves UI and API)
CMD ["node", "server.js"]
