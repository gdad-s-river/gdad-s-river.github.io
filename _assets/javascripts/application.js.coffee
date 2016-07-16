$ ->
  $("a.menu").click ->
    $(".site-header nav").slideToggle 100
    preventDefault

  $(window).resize ->
    w = $(window).width()
    menu = $(".site-header nav")
    menu.removeAttr "style" if w > 680 and menu.is(":hidden")

  $("article.post iframe").wrap "<div class=\"video-container\" />"

  vpH = $(window).height()
  vH = vpH - 350
  $(".overlay").css "height", vH
  $(".featured-image").css "height", vH

  $("<img>").attr("src", ->
    imgUrl = $("div.featured-image").css("background-image")
    return  unless imgUrl
    imgUrl = imgUrl.substring(4, imgUrl.length - 1)
    imgUrl
  ).load ->
    $("img.loading").fadeOut 500
    $("div.overlay").fadeTo "slow", 0.6

  $(".post-list li").each (i) ->
    t = $(this)
    setTimeout (->
      t.addClass "slider"
    ), (i + 1) * 330

Anchor =
  init: ->
    Anchor.slidey = $(".slidey")
    $(window).resize(Anchor.bindResize).trigger "resize"
    Anchor.linky = $(".linky").click(Anchor.toggleSlidey)
    setTimeout (->
      Anchor.hideSlidey()
      $("body").addClass "js-enabled"
    ), 10
    $("a[href=\"#search\"]").click ->
      Anchor.toggleSlidey.call Anchor.linky unless Anchor.linky.hasClass("active")

  hideSlidey: ->
    Anchor.slidey.css "margin-top", @_slideyHeight
    Anchor.linky and Anchor.linky.removeClass("active")
    this

  toggleSlidey: ->
    self = Anchor
    me = $(this)
    me.toggleClass "active"
    self.slidey.css "margin-top", (if me.hasClass("active") then 0 else self._slideyHeight)
    false

  bindResize: ->
    Anchor._slideyHeight = -(Anchor.slidey.height() + 1)
    Anchor.hideSlidey()

$ Anchor.init
