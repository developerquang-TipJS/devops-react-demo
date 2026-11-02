# ---------- Stage 1: build ----------
# Dùng Node để cài dependency và build ra file tĩnh (thư mục dist/)
FROM node:22-alpine AS build
WORKDIR /app

# Copy package*.json trước để tận dụng cache layer:
# nếu dependency không đổi thì Docker không cần chạy lại npm ci
COPY package.json package-lock.json ./
RUN npm ci

# Copy toàn bộ source rồi build
COPY . .
RUN npm run build

# ---------- Stage 2: serve ----------
# Image cuối chỉ chứa Nginx + file tĩnh, không có Node hay node_modules → nhẹ và an toàn hơn
FROM nginx:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
