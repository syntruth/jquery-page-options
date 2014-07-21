class PageOptions
  constructor: (options={}) ->
    @options = options

    this.setup()

  setup: () ->
    @maxPages = @options.maxPages or false
    @fields   = @options.fields or {}

    @fields.page     = 1  unless @fields.hasOwnProperty 'page'
    @fields.per_page = 15 unless @fields.hasOwnProperty 'per_page'

    this._setupMethods()

    return this

  incrPage: () ->
    @fields.page += 1

    @fields.page = @maxPages if @maxPages and @fields.page >= @maxPages

    return @fields.page

  decrPage: () ->
    @fields.page -= 1
    @fields.page  = 1 if @fields.page <= 0

    return @fields.page

  setPage: (page=1) ->
    @fields.page = page
    @fields.page = 1 if @fields.page <= 0

    return @fields.page

  set: (field, value) ->
    # We only set the field if the property
    # already exists on the fields object.
    @fields[field] = value if @fields.hasOwnProperty field

  get: (field) -> @fields[field]

  setMaxPages: (maxPages=Infinity) -> @maxPages = maxPages

  isMaxPage: () -> if @fields.page is @maxPages then true else false

  current: () -> $.extend {}, @fields

  data: (options={}) ->
    options = $.extend this.current(), options

    for field, value of options
      delete options[field] unless value

    return options

  reset: () ->
    this.setup()

    return this

  update: (options={}) ->
    @options = $.extend @options, options

    this.setup()

    return this

  _setupMethods: () ->
    for field of @fields
      this._setupSetMethod(field)
      this._setupGetMethod(field)

    return

  _setupSetMethod: (field) ->
    this["set_#{field}"] = (value) => this.set field, value

    return

  _setupGetMethod: (field) ->
    this["#{field}"] = () => this.get field

    return
