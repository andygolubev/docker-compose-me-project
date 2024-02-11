FROM node:18.12.1 as bundle

RUN mkdir /bundle
WORKDIR /bundle

COPY ./ ./

RUN npm install react-scripts --prefix /frontend/
RUN npm run build


FROM nginx

COPY --from=bundle /bundle/build /usr/share/nginx/frontend

RUN echo '\
server { \n\
    listen       80; \n\
    server_name  localhost; \n\
    location / { \n\
        root   /usr/share/nginx/frontend; \n\
        index  index.html index.htm; \n\
    } \n\
} \n\
' > /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
