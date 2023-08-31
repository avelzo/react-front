# Use a Node.js base image
FROM node:17-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json before other files
# Utilizes Docker cache to save re-installing dependencies if unchanged
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all files
COPY . .

# Build the React app
RUN npm run build

# Serve the React app on port 3000
CMD ["npm", "start"]

#Stage 2
# FROM nginx:latest
# WORKDIR /usr/share/nginx/html
# # RUN rm -rf ./*
# COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
# COPY --from=builder /app/build .
# ENTRYPOINT [ "nginx", "-g", "daemon off;" ]