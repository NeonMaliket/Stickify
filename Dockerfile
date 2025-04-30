# Stage 1: Build the Flutter web app
FROM dart:stable AS build

# Set working directory
WORKDIR /app

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:$PATH"
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

# Copy app files
COPY . .

# Get packages and build web
RUN flutter pub get
RUN flutter build web --dart-define=STICKIFY_API=http://localhost:2222

# Stage 2: Serve the app
FROM nginx:alpine

# Copy built files to nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
