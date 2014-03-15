describe 'BudgetApp.Models.BaseModel', ->
  beforeEach ->
    Grandparent = BudgetApp.Models.BaseModel.extend()
    Parent = Grandparent.extend()
    Child = Parent.extend()

    # this makes an assumption that the collection will always know about the parent
    @grandparent = new Grandparent({}, collection: {})
    @parent = new Parent({}, collection: {parent: @grandparent})
    @child = new Child({}, collection: {parent: @parent})

  it 'triggers a parent change when an attribute is set on the child', (done) ->
    @parent.on('change', -> done())
    @child.set('foo', 'bar')

  it 'triggers a parent change when the child is deleted', (done) ->
    @parent.on('change', -> done())
    @child.destroy()

  it 'triggers a grandparent change when an attribute is set on the child', (done) ->
    @grandparent.on('change', -> done())
    @child.set('foo', 'bar')

  it 'triggers a grandparent change when the child is deleted', (done) ->
    @grandparent.on('change', -> done())
    @child.destroy()

  it 'returns the id as the uid if present', ->
    @child.id = 'the id'
    expect(@child.uid()).toEqual('the id')

  it 'generates a uid if id is not present', ->
    expect(@child.uid().length).toEqual(36)

