FROM silex/emacs:27.1

RUN apt-get update --quiet
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install --assume-yes nodejs make
RUN npm install --global ansi-to-html pm2

WORKDIR /usr/src/app
COPY package.json .
RUN npm install --production
COPY . .

RUN mkdir -p /root/.emacs.d
COPY init.el /root/.emacs.d
COPY init-e2ansi.el /root/.emacs.d
# podman build -t color --build-arg ELPA_MIRROR=tuna .
ARG ELPA_MIRROR=""
RUN ELPA_MIRROR=$ELPA_MIRROR emacs -Q --batch -l /root/.emacs.d/init.el /root/.emacs.d/init.el
RUN cd public && make --always-make EMACS_COMMAND="emacs -Q --batch -l /root/.emacs.d/init.el"

ENV COMMAND_TEMPLATE="emacs -Q --batch -l /root/.emacs.d/init.el -l /root/.emacs.d/init-e2ansi.el %s - | ansi-to-html"

EXPOSE 3478
CMD [ "pm2-runtime", "npm", "--", "start" ]
