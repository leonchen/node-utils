gulp = require 'gulp'
watch = require 'gulp-watch'
async = require 'async'
{spawn} = require 'child_process'

pids = {}
restartTimeout = null

module.exports = helper =

  devServer: (cmd, watchDirs) ->
    watch watchDirs, ->
      clearTimeout restartTimeout if restartTimeout
      restartTimeout = setTimeout ->
        main.startServer(cmd)
      , 1000

  startServer: (cmd) ->
    if pids.length > 0
      async.each pids, (pid, cb) ->
        main.kill pid, cb
      , (err) ->
        if err
          console.warn err
          process.exit(1)
          return

        main.startServer(cmd)
      return

    console.log "starting server"
    args = cmd.split /\s+/
    server = spawn args[0], args[1..]
    pids[server.pid] = true

    server.stdout.on "data", (data) -> console.log data.toString().trim()
    server.stderr.on "data", (data) -> console.warn data.toString().trim()

  kill: (pid, cb) ->
    console.log "killing #{pid}"
    k = spawn "kill", [ pid ]
    k.on 'close', (code) ->
      delete pids[pid] unless code
      cb code
