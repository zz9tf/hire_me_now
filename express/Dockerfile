FROM node:19-slim

WORKDIR /express

RUN npm install -g nodemon

COPY package*.json .

RUN npm install

COPY . .

EXPOSE 9000

CMD ["npm", "start"]