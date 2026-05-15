# syntax=docker/dockerfile:1
# Use dev variant for building
FROM dhi.io/node:26-debian13-dev AS build-stage

WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install dependencies and ensure node_modules exists
RUN npm ci 

COPY . .

RUN npm run build

# Use runtime variant for final image
FROM dhi.io/nginx:1-debian13-dev AS runtime-stage

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy node_modules from build stage
COPY --from=build-stage /usr/src/app/build /usr/share/nginx/html

# Expose port (use non-privileged port)
EXPOSE 80

# Start the application
CMD ["nginx", "-g", "daemon off;"]
