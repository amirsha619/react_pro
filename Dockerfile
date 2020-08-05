# docker file to illustrate multistep build  by tagging phase as builder
FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
CMD ["npm","run","build"]

#second phase for nginx server : copy build folder from previous phase
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html/