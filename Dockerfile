# Use official Node.js 22 LTS image for compatibility with Vite plugin
# syntax=docker/dockerfile:1

FROM public.ecr.aws/docker/library/node:22-alpine

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
