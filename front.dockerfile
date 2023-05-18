#FROM node:20
FROM node:20.2-slim

EXPOSE 3000

COPY frontend/ /frontend
RUN npm install react-scripts --prefix /frontend/


ENTRYPOINT ["npm", "run", "start", "--prefix", "/frontend/"]
