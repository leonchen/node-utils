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
        helper.startServer(cmd)
      , 1000

    helper.startServer(cmd)

  startServer: (cmd) ->
    running = Object.keys(pids)
    if running.length > 0
      async.each running, (pid, cb) ->
        helper.kill pid, cb
      , (err) ->
        if err
          console.warn err
          process.exit(1)
        else
          helper.startServer(cmd)
    else
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
