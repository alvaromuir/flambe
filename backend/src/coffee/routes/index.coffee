exports.index = (req, res) ->
  res.render 'index', 
    title: 'flambé'

exports.login = (req, res) ->
    res.render 'login', 
      title: 'flambé'