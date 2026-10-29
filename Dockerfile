# Use official Node.js 22 LTS image for compatibility with Vite plugin
# syntax=docker/dockerfile:1

FROM ghcr.io/marx-org/base-node:22-alpine@sha256:4c555748c9819babb757c7c328a12443b9d242edcfcc11cd196c24623dc704dd

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
