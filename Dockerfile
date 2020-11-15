FROM silex/emacs:27.1
ENV NODE_ENV=production
ENV COMMAND_TEMPLATE="emacs -Q --batch -l /root/.emacs.d/init.el -l /root/.emacs.d/init-e2ansi.el --colors 256 --color-class color %s - | ansi-to-html"

# Install node, make and pm2
RUN apt-get update --quiet
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install --assume-yes nodejs make
RUN npm install --global ansi-to-html pm2

# Install Node deps
WORKDIR /usr/src/app
COPY package.json .
RUN npm install

# Install Emacs deps
RUN mkdir -p /root/.emacs.d
COPY init.el /root/.emacs.d
COPY init-e2ansi.el /root/.emacs.d
ARG ELPA_MIRROR
RUN ELPA_MIRROR=$ELPA_MIRROR emacs -Q --batch -l /root/.emacs.d/init.el /root/.emacs.d/init.el

# Regenerate public/data.json,index.html
COPY . .
RUN cd public && make --always-make EMACS_COMMAND="emacs -Q --batch -l /root/.emacs.d/init.el"

EXPOSE 3478

CMD [ "pm2-runtime", "npm", "--", "start" ]
