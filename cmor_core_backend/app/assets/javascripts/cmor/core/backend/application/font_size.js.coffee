class FontSizeSelector
  SIZES: ["size-xs", "size-sm", "size-md", "size-lg", "size-xl"]
  DEFAULT_SIZE: "size-md"

  _sizes: ->
    @SIZES
  
  _defaultSize: ->
    @DEFAULT_SIZE
  
  _currentFontSize: =>
    currentFontSize = null
    this._sizes().forEach (size) =>
      if this._targetClassesArray().includes(size)
        console.log("hit:", size)
        currentFontSize = size
        return
    console.log("currentFontSize", currentFontSize)
    if currentFontSize != null
      return currentFontSize
    console.log("returning default size")
    this._defaultSize()

  _indexOfCurrentFontSize: =>
    this._sizes().indexOf(this._currentFontSize())

  _nextFontSize: =>
    this._sizes()[this._indexOfCurrentFontSize() + 1]

  _previousFontSize: =>
    this._sizes()[this._indexOfCurrentFontSize() - 1]

  increaseFontSize: ->
    if this._nextFontSize() == undefined
      return 
    curr = this._currentFontSize()
    next = this._nextFontSize()
    this._target().removeClass(curr)
    this._target().addClass(next)

  decreaseFontSize: ->
    if this._previousFontSize() == undefined
      return 
    curr = this._currentFontSize()
    prev = this._previousFontSize()
    this._target().removeClass(curr)
    this._target().addClass(prev)

  resetFontSize: =>
    this._sizes().forEach (size) =>
      this._target().removeClass(size)
  
  setFontSize: (size) =>
    this.resetFontSize()
    this._target().addClass(size)

  storeCurrentFontSize: =>
    localStorage.setItem("cmorCoreBackend.fontSize", this._currentFontSize());

  fetchCurrentFontSize: =>
    localStorage.getItem("cmorCoreBackend.fontSize");
  
  _target: ->
    @target ||= $(@targetSelector)
  
  _targetClassesArray: =>
    this._target().attr("class").split(" ")
  
  constructor: (targetSelector, increaseButtonSelector, decreaseButtonSelector, resetButtonSelector) ->
    @targetSelector = targetSelector
    @increaseButtonSelector = increaseButtonSelector
    @decreaseButtonSelector = decreaseButtonSelector
    @resetButtonSelector = resetButtonSelector

    this.setFontSize(this.fetchCurrentFontSize() || this._defaultSize())

    $(document).on 'click', increaseButtonSelector, (e) =>
      this.increaseFontSize()
      this.storeCurrentFontSize()

    $(document).on 'click', decreaseButtonSelector, (e) =>
      this.decreaseFontSize()
      this.storeCurrentFontSize()

    $(document).on 'click', resetButtonSelector, (e) =>
      this.resetFontSize()
      this.storeCurrentFontSize()


$(document).ready ->
  fontSizeSelector = new FontSizeSelector("body", "[data-font-size-increase]", "[data-font-size-decrease]", "[data-font-size-reset]")
  console.log(fontSizeSelector)


  
#  target = document.body;
#  newBodySize = localStorage.getItem("cmorCoreBackend.bodySize");
#  target.style.fontSize = newBodySize;
#
#  sizes = ["size-xs", "size-sm", "size-md", "size-lg", "size-xl"]
#  
#  $(document).on 'click', '[data-font-size-increase]', (e)->
#    target = $('body');
#    classes = target.attr('class').split(" ");
#    if(classes.some((v) => sizes.includes(v)))
#      currentSize = sizes.each((size) => classes.indexOf(size)
#      index = sizes.indexOf(currentSize);
#
#      if(index >= 0 && index < sizes.length - 1)
#        newSize = sizes[index + 1]
#        console.log("newSize", newSize)
#        target.removeClass(currentSize)
#        target.addClass(newSize)
#        localStorage.setItem("cmorCoreBackend.bodySize", newSize);
#    classes = target.attr('class');
#    console.log(classes)
#
#  $(document).on 'click', '[data-font-size-decrease]', (e)->
#    target = $('body');
#    classes = target.attr('class');
#    regex = "/([#{sizes.join("|")}]{7})/gm"
#    console.log("regex", regex)
#    console.log("matches", classes.match(regex))
#    currentSize = (classes.match(regex) || ["size-md"])[0]
#    console.log(classes)
#    console.log(regex)
#    console.log("currentSize", currentSize)
#
#    index = sizes.indexOf(currentSize);
#    if(index >= 0 && index < sizes.length - 1)
#      newSize = sizes[index - 1]
#      console.log("newSize", newSize)
#      target.removeClass(currentSize)
#      target.addClass(newSize)
#      localStorage.setItem("cmorCoreBackend.bodySize", newSize);
#    classes = target.attr('class');
#    console.log(classes)
#
#  $(document).on 'click', '[data-font-size-reset]', (e)->
#    target = $('body');
#    classes = target.attr('class');
#    console.log(classes)
#    regex = "/([#{sizes.join("|")}]{7})/gm"
#    console.log("regex", regex)
#    console.log("matches", classes.match(regex))
#    currentSize = (classes.match(regex) || ["size-md"])[0]
#    if(currentSize != "size-md")
#      console.log("currentSize", currentSize)
#      target.removeClass(currentSize)
#      localStorage.removeItem("cmorCoreBackend.bodySize");
#    classes = target.attr('class');
#    console.log(classes)