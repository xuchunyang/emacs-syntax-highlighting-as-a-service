FROM silex/emacs:27.1

RUN apt-get update --quiet
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install --assume-yes nodejs
RUN npm install --global ansi-to-html

RUN mkdir -p /root/.emacs.d
COPY init.el /root/.emacs.d
RUN emacs -Q --batch -l /root/.emacs.d/init.el /root/.emacs.d/init.el

ENV COMMAND_TEMPLATE="emacs -Q --batch -l /root/.emacs.d/init.el --mode %s - | ansi-to-html"

WORKDIR /usr/src/app
COPY package.json .
RUN npm install
EXPOSE 3478
CMD [ "npm", "start" ]
COPY . .
