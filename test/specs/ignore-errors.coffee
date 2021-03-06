{stream, prop, send, Kefir} = require('../test-helpers.coffee')



describe 'ignoreErrors', ->


  describe 'stream', ->

    it 'should return stream', ->
      expect(stream().ignoreErrors()).toBeStream()

    it 'should activate/deactivate source', ->
      a = stream()
      expect(a.ignoreErrors()).toActivate(a)

    it 'should be ended if source was ended', ->
      expect(send(stream(), ['<end>']).ignoreErrors()).toEmit ['<end:current>']

    it 'should handle events', ->
      a = stream()
      expect(a.ignoreErrors()).toEmit [1, 2, '<end>'], ->
        send(a, [1, {error: -1}, 2, {error: -2}, '<end>'])





  describe 'property', ->

    it 'should return property', ->
      expect(prop().ignoreErrors()).toBeProperty()

    it 'should activate/deactivate source', ->
      a = prop()
      expect(a.ignoreErrors()).toActivate(a)

    it 'should be ended if source was ended', ->
      expect(send(prop(), ['<end>']).ignoreErrors()).toEmit ['<end:current>']

    it 'should handle events and current', ->
      a = send(prop(), [{error: -1}])
      expect(a.ignoreErrors()).toEmit [2, 3, '<end>'], ->
        send(a, [2, {error: -2}, 3, {error: -3}, '<end>'])
      a = send(prop(), [1])
      expect(a.ignoreErrors()).toEmit [{current: 1}, 2, 3, '<end>'], ->
        send(a, [2, {error: -2}, 3, {error: -3}, '<end>'])




