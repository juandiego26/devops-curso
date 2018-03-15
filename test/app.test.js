const request = require('supertest')

const app = require('../app')

describe('app', function() {
  it('should server HTML on index', (done) => {
    request(app).get('/').expect('content-Type', /html/).expect(200, done)
  })
})
