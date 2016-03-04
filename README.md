# mtg

## Development

### Pre-reqs

- node/npm
- haxe
- hmm (haxe module manager)

### First-time setup

```sh
git clone git@github.com:andywhite37/mtg
cd mtg
npm install
hmm install
```

### Development

The `gulp` default task starts a nodemon server for the express/abe server
app, and a live-reload-enabled watch task for all client files.

```sh
gulp
```
