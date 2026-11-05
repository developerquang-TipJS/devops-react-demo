# React + Vite

This template provides a minimal setup to get React working in Vite with HMR and some Oxlint rules.

Currently, two official plugins are available:

- [@vitejs/plugin-react](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react) uses [Oxc](https://oxc.rs)
- [@vitejs/plugin-react-swc](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react-swc) uses [SWC](https://swc.rs/)

## React Compiler

The React Compiler is not enabled on this template because of its impact on dev & build performances. To add it, see [this documentation](https://react.dev/learn/react-compiler/installation).

## Expanding the Oxlint configuration

If you are developing a production application, we recommend using TypeScript with type-aware lint rules enabled. Check out the [TS template](https://github.com/vitejs/vite/tree/main/packages/create-vite/template-react-ts) for information on how to integrate TypeScript and Oxlint's TypeScript related rules in your project.
# devops-react-demo


# Một quy trình DevOps đầy đủ gồm các bước như sau:

1. Code        →  Git, GitHub
2. Kiểm tra    →  Lint, test (job build trong ci.yml)
3. Đóng gói    →  Dockerfile
4. Lưu trữ     →  Registry (ghcr.io, Docker Hub)
─────────────────────────────────────────────────────
5. Hạ tầng     →  Server, cloud (AWS, Azure…), Terraform
6. Triển khai  →  Đưa image lên server (CD), Kubernetes
7. Giám sát    →  Log, cảnh báo, đo hiệu năng (Grafana, Prometheus)
8. Phản hồi    →  Thấy lỗi → sửa code → quay lại bước 1

Bước 2 và 4 do ci.yml đảm nhiệm, còn bước 3 do Dockerfile đảm nhiệm. File ci.yml là thứ nối các bước lại với nhau thành một dây chuyền tự động. Vì vậy, nếu phải chọn một file "mang tinh thần DevOps" nhất, thì đó là ci.yml chứ không phải Dockerfile.

<!-- Dockerfile -->
Stage 1 (build)                         Stage 2 (image cuối)
┌──────────────────────┐                ┌──────────────────────────┐
│ Node 22              │                │ Nginx                    │
│ node_modules (~100MB)│                │ nginx.conf  ← từ máy bạn │
│ src/, package.json…  │                │                          │
│ dist/  ──────────────┼── --from=build─▶ /usr/share/nginx/html/   |
└──────────────────────┘                └──────────────────────────┘