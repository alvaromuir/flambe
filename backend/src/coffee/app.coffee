
###
Module dependencies.
###
express   = require 'express'
http      = require 'http'
path      = require 'path'
everyauth = require 'everyauth'

routes    = require './routes'
details   = require './routes/details'
profile   = require './routes/profile'


auth      = require './lib/auth_config'
dbConfig  = require './lib/db_config'
setup     = require './lib/setup'
tools     = require './lib/tools'

app       = express()

dbSetup = 
  uri: setup.dataBaseURI
  name: setup.serverName


# initalize auth
auth.init everyauth


# all environments
app.set 'port', process.env.PORT or 3000
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.use express.favicon path.join(__dirname, 'public/favicon.ico') 
app.use express.bodyParser()
app.use express.cookieParser('iz bklyn in da house')
app.use express.session
  secret: 'W!th0ut@d0u3t'
app.use everyauth.middleware(app)
app.use express.methodOverride()
app.use app.router
app.use express.static path.join(__dirname, 'public')



# development only
if 'development' is app.get('env')
  app.use express.errorHandler()
  # app.use express.logger 'dev'
  # auth.debug = true
  app.locals.pretty = true


#routes
app.get '/', routes.index
app.get '/login', routes.login
app.get '/details', details.index
app.get '/profile', profile.index

# Here. We. Go.
http.createServer(app).listen app.get('port'), ->
  console.log 'Express server listening on port ' + app.get('port')

# SocketI/O
require('./lib/sockets').init http.createServer(app)