# First stage: build app and get 
# static content in build dir.
FROM node:16-alpine as builder
RUN mkdir -p /apps && \
    chown node /apps
WORKDIR '/apps'
USER node
COPY --chown=node:node package.json .
RUN npm install
COPY --chown=node:node . .
RUN npm run build

# Second Stage: run nginx server by putting
# created build dir from builder stage into
# /use/share/nginx/html
FROM nginx
EXPOSE 80
COPY --from=builder /apps/build /usr/share/nginx/html
