# Step 1: Build the React app
FROM node:16-alpine AS build-stage

WORKDIR /usr/src/app

# Copy package.json and package-lock.json
#COPY package*.json ./
COPY . .
# Install dependencies
RUN npm install

# Copy source code into the container
#COPY . .

# Build the React app
RUN npm run build

# Step 2: Serve the app using Nginx
FROM docker.io/nginx:latest

# Copy the build files from the build stage
COPY --from=build-stage /usr/src/app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

