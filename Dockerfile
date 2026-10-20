# Use official Node.js 22 LTS image for compatibility with Vite plugin
# syntax=docker/dockerfile:1

FROM ghcr.io/marx-org/base-node:22-alpine@sha256:2be4359005a5800a6aa0bbb3236327132b12509cc4c345f5bccfe6b4b56ebe43

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
