# syntax=docker/dockerfile:1

# -----------------------------
#  Builder Stage (Install Tools)
# -----------------------------
    FROM node:20-alpine AS builder

    WORKDIR /workspace
    
    # Install additional tools (if needed for build)
    RUN apk add --no-cache curl
    
    # Copy source code (assumes your frontend lives in /workspace)
    COPY . .
    
    # Install dependencies and build project
    RUN npm ci && npm run build
    
    # -----------------------------
    # 🚀 Production Stage (Serve App)
    # -----------------------------
    FROM nginx:alpine
    
    # Copy custom nginx config (optional: only include if used)
    # COPY nginx.conf /etc/nginx/nginx.conf
    
    # Copy built frontend from builder
    COPY --from=builder /workspace/dist /usr/share/nginx/html
    
    # Expose port and set default command
    EXPOSE 80
    CMD ["nginx", "-g", "daemon off;"]
    
    # -----------------------------
    #  Maintainer Info
    # -----------------------------
    LABEL maintainer="felixmftc@icloud.com"
    LABEL org.opencontainers.image.source="https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME"
    