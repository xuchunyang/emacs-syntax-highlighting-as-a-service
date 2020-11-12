# Emacs syntax highlighting as a service

A website to syntax highlighting code (or any text supported by Emacs),

https://emacs-syntax-highlighting-as-a-service.xuchunyang.me

which is powered by GNU Emacs using
[e2ansi](https://github.com/Lindydancer/e2ansi) and
[ansi-to-html](https://www.npmjs.com/package/ansi-to-html).

## Run

### Container

    # 1. Build the image
    $ podman build -t color .
    
    # 2. Start the server
    $ podman run -d --rm -p 3478:3478 color

### Local

    # 1. Install e2ansi
    M-x package-install e2ansi
    
    # 2. Install ansi-to-html
    $ npm install --global ansi-to-html
    
    # 3. Export COMMAND_TEMPLATE
    export COMMAND_TEMPLATE="emacs -Q --batch -l ~/.emacs.d/init.el --mode %s - | ansi-to-html"
    
    # 4. Start the server
    npm start

then visit http://localhost:3478/
