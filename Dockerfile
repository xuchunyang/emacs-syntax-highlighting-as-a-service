FROM silex/emacs:27.1

RUN apt-get update --quiet
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install --assume-yes nodejs
RUN npm install --global ansi-to-html

RUN mkdir -p /root/.emacs.d
COPY init.el /root/.emacs.d
# podman build -t color --build-arg ELPA_MIRROR=tuna .
ARG ELPA_MIRROR=""
RUN ELPA_MIRROR=$ELPA_MIRROR emacs -Q --batch -l /root/.emacs.d/init.el /root/.emacs.d/init.el

ENV COMMAND_TEMPLATE="emacs -Q --batch -l /root/.emacs.d/init.el %s - | ansi-to-html"

WORKDIR /usr/src/app
COPY package.json .
RUN npm install
COPY . .
RUN apt-get install --assume-yes make
RUN cd public && make --always-make EMACS_COMMAND="emacs -Q --batch -l /root/.emacs.d/init.el"
EXPOSE 3478
RUN npm install --global pm2
CMD [ "pm2-runtime", "npm", "--", "start" ]
