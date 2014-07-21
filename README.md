This is a very simple Library that encapsulates pagination data.

By default, it will only keep track of two fields: `page` and `per_page`.
But you can add other fields that can be passed to an AJAX call by defining
them, along with a default value, as part of the PageOptions options hash
passed to the constructor.

All fields also generate helper methods on the object, in the form of `set_*`
for setters and just the field name for getters.

Any fields that have false-y values will not be included in the data hash that
is returned from the `#data` method.

Example:

    pageOpts = new PageOptions({
      for_tag: false
    })

    pageOpts.data() // => {page: 1, per_page: 15}

    pageOpts.set_for_tag('test')

    pageOpts.data() // => {page: 1, per_page: 15, for_tag: 'test'}

    pageOpts.incrPage()

    pageOpts.data() // => {page: 2, per_page: 15, for_tag: 'test'}

    pageOpts.set_per_page(20)

    pageOpts.data() // => {page: 2, per_page: 20, for_tag: 'test'}

    pageOpts.update({for_user: false})

    pageOpts.data() // => {page: 2, per_page: 20, for_tag: 'test'}

    pageOpts.set_for_user('idnum')

    pageOpts.data() // => {page: 2, per_page: 20, for_tag: 'test', for_user: 'idnum'}

    pageOpts.reset()

    pageOpts.data() // => {page: 1, per_page: 15}


