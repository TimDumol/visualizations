# This is really just hacked together. This should be rewritten. Haha.

express = require 'express'
app = express()
r = require 'rethinkdb'
Q = require 'q'
winston = require 'winston'
_ = require 'underscore'

app.use(express.cookieParser())
app.use(express.bodyParser())

# Routes
app.get '/', (req, res) ->
  res.type 'html'
  fs.readFile "#{__dirname}/../frontend/index.html", {encoding: 'utf8', flag: 'r'}, (err, data) ->
    res.send(200, data)
app.use '/css', express.static("#{__dirname}/../frontend/css")
app.use '/js', express.static("#{__dirname}/../frontend/js")
app.use '/lib', express.static("#{__dirname}/../frontend/lib")
app.use '/templates', express.static("#{__dirname}/../frontend/templates")

app.listen 3000
winston.info 'Listening on port 3000'
