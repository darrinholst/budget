describe "Itemization", ->
  bucket = null
  itemization = null

  beforeEach ->
    bucket = new BudgetApp.Models.Bucket()
    itemization = new BudgetApp.Models.Itemization(bucket: bucket)

  it "triggers a change on the expense when changed", ->
    bucketChanged = false
    bucket.on('change', -> bucketChanged = true)
    itemization.spent('100')
    expect(bucketChanged).toBe(true)


