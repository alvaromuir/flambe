# Testing Stuff

mocha   = require 'mocha'
chai    = require 'chai'
_       = require 'lodash'
moment  = require 'moment'

assert  = chai.assert
expect  = chai.expect
should  = chai.should()

crud    = require '../lib/crud'
usrData = require './data/users'

tmpUsrs = []

describe "quick addition test", ->
  it "is expected to add 1+1 correctly", (done) ->
    onePlusOne = 1 + 1
    expect(onePlusOne).to.equal(2)
    done()

describe "Database setup", ->
  it "should return the db name, 'flambe_test'", (done) ->
    current_db = crud.setup.db.connections[0].name
    current_db.should.equal 'flambe_test'
    done()

  # Users
  it "should have a 'User' schema", (done) ->
    _.contains(crud.setup.schemaList, 'User').should.equal true
    done()

    describe "schema operations",  ->
      User        = crud.User
      total       = usrData.length
      random_usr  = usrData[_.random 0, total - 1]
      count       = 1

      before (done) ->
        tmpUserModel = crud.setup.models['User']
        tmpUserModel.remove {}, (err) ->
          # console.log 'User collection removed.'
          done()

      # Create
      it "should be able to create users", (done) ->

        _.forEach usrData, (usr) ->
          User.create usr, (rslt) ->
            tmpUsrs.push rslt
            # console.log 'user #', count, ' created'
            count += 1
            if count is total
              done()

      # Read
      it "should be able to find users by criteria", (done) ->
        usr = random_usr
        random_key = _.keys(usr)[_.random 0, _.keys(usr).length - 1]
        query = {}
        query[random_key] = usr[random_key]
        queryRslt = ''

        User.read query, (rslt) ->
          queryRslt = rslt[0]
          rslt[0][random_key].should.equal usr[random_key]
          done()

        describe "which have appropriate defaults that", ->
          it "is expected to have a creation date",  (done) ->
            expect(queryRslt.createdOn).to.be.a('date')
            done()

      it "should be able to find a user by ID", (done) ->
        random_usr = tmpUsrs[_.random 0, total - 1]

        User.readById random_usr._id, (rslt) ->
          rslt.displayName.should.equal random_usr.displayName
          done()

      it "should be able to find a single user by criteria", (done) ->
        match = /rocknation.com/i
        query = {email: match}
        User.readOne query, (rslt) ->
          match.test(rslt.email).should.equal true
          done()

      # Update
      it "should be able to update records by criteria", (done) ->
        match = /rocknation.com/i
        query = {email: match}
        User.read query, (rslt) ->
          total = rslt.length
          count =  0
          _.forEach rslt, (rcrd) ->
            emailName = rcrd.email.split('@')[0]
            query     = email: rcrd.email
            update    = email: emailName+'@defjam.com'

            User.update query, update, (err, num, raw) ->
              done(err) if err
              # console.log 'results :', raw
              User.readById _id:rcrd._id, (rslt) ->
                rslt.email.should.equal update.email
                count += 1
                if count is total
                  done()

      it "should be able to update a record by ID", (done) ->
        random_usr  = tmpUsrs[_.random 0, total - 1]
        updates     = status: 'updated by id test suite on ' + moment().toString()

        User.updateByID random_usr._id, updates, (err, rslt) ->
          rslt.status.should.equal updates.status
          done()

      it "should be able to update a single record by criteria", (done) ->
        random_usr = _.clone(tmpUsrs[_.random 0, total - 1])._doc
        delete random_usr.__v
        delete random_usr.verified
        delete random_usr.validated
        random_key = _.keys(random_usr)[_.random 0, _.keys(random_usr).length - 1]
        query = {}
        query[random_key] = random_usr[random_key]
        updates = status: 'updated by criteria in test suite on ' + moment().toString()
        
        User.updateOne query, updates, (err, rslt) ->
          done(err) if err
          done()

      # Delete
      it "should be able to delete records by criteria", (done) ->
        random_usr = _.clone(tmpUsrs[_.random 0, total - 1])._doc
        delete tmpUsrs[random_usr]
        delete random_usr.__v
        delete random_usr.verified
        delete random_usr.validated
        
        random_key = _.keys(random_usr)[_.random 0, _.keys(random_usr).length - 1]
        query = {}
        query[random_key] = random_usr[random_key]

        User.read query, (rslt) ->
          User.delete rslt[0], (err) ->
            User.readById rslt[0]._id, (err, rslt) ->
              done(err) if err
              expect(rslt).to.be.undefined
              done()


      it "should be able to delete a record by ID", (done) ->
        random_usr = _.clone(tmpUsrs[_.random 0, total - 1])._doc
        delete tmpUsrs[random_usr]

        User.deleteByID random_usr._id, {}, (rslt) ->
          # console.log rslt
          done()

      it "should be able to delete a single record by criteria", (done) ->
        random_usr = _.clone(tmpUsrs[_.random 0, total - 1])._doc
        delete tmpUsrs[random_usr]
        delete random_usr.__v
        delete random_usr.verified
        delete random_usr.validated
        
        random_key = _.keys(random_usr)[_.random 0, _.keys(random_usr).length - 1]
        query = {}
        query[random_key] = random_usr[random_key]

        User.deleteOne query, {}, (err, rslt) ->
          User.readOne query, (err, rslt) ->
            done(err) if err
            expect(rslt).to.be.undefined
            done()


      it "should be able to delete records quickly", (done) ->
        total = tmpUsrs.length
        count = 0
        _.forEach tmpUsrs, (usr) ->
          query = _id: usr._id
          User.deleteQuick query
          count += 1
          if count is total
            User.count {}, (rslt) ->
              expect(rslt).to.equal 0
              done()