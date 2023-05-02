# Use an official Node.js runtime as a parent image
FROM node:14-alpine as build

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files into the container at /app
COPY package*.json ./

# Install any needed packages
RUN npm install

# Copy the rest of the application code into the container at /app
COPY . .

# Build the React app for production
RUN npm run build

# Use an official Nginx runtime as a parent image
FROM nginx:1.21.1-alpine

# Copy the build folder from the previous stage into the container at /usr/share/nginx/html
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for Nginx to listen on
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

