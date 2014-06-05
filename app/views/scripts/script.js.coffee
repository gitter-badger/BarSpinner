<%=  raw "`#{ render 'scripts/animate'}`" %>
window.Animator = Animator
window.NumericalStyleSubject = NumericalStyleSubject
bindReady = (callback) ->
  ready = (called)->
    return  if called
    called = true
    callback()
  called = false
  if document.addEventListener
    document.addEventListener("DOMContentLoaded", ()->
      ready()
    , false)
  else if document.attachEvent
    if document.documentElement.doScroll and window is window.top
      tryScroll = ->
        return  if called
        return  unless document.body
        try
          document.documentElement.doScroll "left"
          ready()
        catch e
          setTimeout tryScroll, 1000
      tryScroll()
    document.attachEvent "onreadystatechange", ->
      ready()  if document.readyState is "complete"
  if window.addEventListener
    window.addEventListener "load", ready, false
  else window.attachEvent "onload", ready  if window.attachEvent

window.MessageBar = (options) ->
  getCookie = (name) ->
    matches = document.cookie.match(new RegExp("(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, "\\$1") + "=([^;]*)"))
    (if matches then decodeURIComponent(matches[1]) else `undefined`)

  setCookie = (name, value, exp) ->
    if typeof exp is "number" and exp
      date = new Date()
      date.setTime date.getTime() + exp * 1000
      exp = date
    exp = exp.toUTCString()  if exp and exp.toUTCString
    value = encodeURIComponent(value)
    document.cookie = name + "=" + value + "; expires=" + exp + "; path=/"

  deleteCookie = (name) ->
    setCookie name, null, -1

  showOpenlink = ->
    document.getElementById("message_bar").style.top = "-38px"
    document.getElementById("message_bar_open").style.top = "-14px"

  animate_links = (direction)->
    if direction is "up"
      bar = new Animator(
        transition: Animator.makeBounce(2)
        duration: 800
      )
      bar.addSubject new NumericalStyleSubject("message_bar", "top", 0, -38)
      bar.toggle()
      open_link = new Animator(
        transition: Animator.makeBounce(2)
        duration: 800
      )
      open_link.addSubject new NumericalStyleSubject("message_bar_open", "top", -96, -14)
      open_link.toggle()
    else
      if direction is "down"
        bar = new Animator(
          transition: Animator.makeBounce(2)
          duration: 800
        )
        bar.addSubject new NumericalStyleSubject("message_bar", "top", -38, 0)
        bar.toggle()
        open_link = new Animator(
          transition: Animator.makeBounce(2)
          duration: 800
        )
        open_link.addSubject new NumericalStyleSubject("message_bar_open", "top", -14, -96)
        open_link.toggle()

  MessageBar.closeBar = ->
    setCookie "message_bar", "hide", 366 * 24 * 3600
    animate_links("up")

  MessageBar.showBar = ->
    setCookie "message_bar", "show", 366 * 24 * 3600
    animate_links("down")

  buildDiv = (options) ->
    newDiv = document.createElement("div")
    newDiv.id = "message_bar"
    newDiv.style.position = "fixed"
    newDiv.style.top = "0px"
    newDiv.style.left = "0px"
    newDiv.style.zIndex = "5000"
    newDiv.style.backgroundColor = options.background
    newDiv.style.color = options.text_color
    newContent = document.createElement("span")
    newContent.textContent = options.message
    newContent.id = 'message_bar_message'
    newDiv.appendChild newContent
    inner_link = document.createElement(options.display_as)
    inner_link.id = "message_bar_link"
    inner_link.style.color = options.link_color
    inner_link.style.fontFamily = options.font_type 
    inner_link_text = document.createTextNode(options.inner_link_text)
    inner_link.appendChild inner_link_text
    inner_link.href = options.inner_link_url 
    newDiv.appendChild inner_link
    botDiv = document.createElement("div")
    botDiv.id = "message_bar_shadow"
    topDiv = document.createElement("div")
    topDiv.id = "message_bar_top"
    newDiv.appendChild botDiv
    close_link = document.createElement("a")
    close_link.id = "message_bar_close"
    close_link.href = "javascript:void(0)"
    close_link.onclick = () ->
      MessageBar.closeBar()
    onclick = close_link.getAttribute("onclick")
    unless typeof (onclick) is "function"
      close_link.setAttribute "onclick", "MessageBar.closeBar();"
    open_link = document.createElement("a")
    open_link.id = "message_bar_open"
    open_link.href = "javascript:void(0)"
    open_link.onclick = () ->
      MessageBar.showBar()
    unless typeof (onclick) is "function"
      open_link.setAttribute "onclick", "MessageBar.showBar();"
    if options.can_close is "true"
      newDiv.appendChild close_link
    newDiv.appendChild open_link
    newDiv.appendChild close_link
    first_elem = document.body.firstChild
    document.body.insertBefore newDiv, first_elem
    document.body.insertBefore topDiv, newDiv
    head = document.getElementsByTagName("head")[0]
    style = document.createElement("style")
    rules = document.createTextNode(options.style_string)
    style.type = "text/css"
    if style.styleSheet
      style.styleSheet.cssText = rules.nodeValue
    else
      style.appendChild rules

    head.appendChild style

  initialize = ->
    current_cookie = getCookie("message_bar")
    buildDiv options
    if options.can_close is "false"
      setCookie "message_bar", "show", 366 * 24 * 3600
    else
      unless current_cookie
        setCookie "message_bar", "show", 366 * 24 * 3600
      else
        if current_cookie is "hide"
          showOpenlink()
        
  initialize()
  
bindReady ->
  window.MessageBar(
    message: "<%=  @bar.message %>"
    background: "<%= @bar.setting.try :bar_color %>"
    text_color: "<%= @bar.setting.try :text_color %>"
    link_color: "<%= @bar.setting.try :link_color%>"
    inner_link_text: "<%=  @bar.link_text %>"
    inner_link_url: "<%=  ['//', request.host_with_port, '/link/', @bar.id].join() %>"
    can_close: true
    display_as: 'a'

    style_string: "
    #message_bar {
      font-family: serif;
      background: #EB583C;
      border-bottom-color: white;
      font-size: 14px;
      font-weight: normal;
      height: 30px;
      line-height: 30px;
      margin: 0;
      overflow: visible;
      padding: 0;
      position: relative;
      text-align: center;
      width: 100%;
      z-index: 1000;
      border-bottom-width: 3px;
      border-bottom-style: solid;border-bottom-color: white;
    } 
    #message_bar_shadow{
      position: absolute;
      bottom: -8px;
      left: 0;
      width: 100%;
      height: 8px;
      line-height: 8px;
      overflow: hidden;
      background: url(http://assets-hellobar-com.s3.amazonaws.com/system/modules/hellobar/lib/sprite-8bit.png);
    }
    #message_bar_link{
      margin-left: 10px;
    }
    #message_bar_top{
      height: 33px;
    }
    a#message_bar_open, a#message_bar_open:link, a#message_bar_open:visited {
      background-image: url(//assets-hellobar-com.s3.amazonaws.com/system/modules/hellobar/lib/sprite-8bit.png);
      background-repeat: no-repeat;
      background-position: 0 -8px;
      background-color: inherit;
      border-color: white;
      display: block;
      height: 0;
      overflow: hidden;
      padding: 80px 0 0;
      position: absolute;
      right: 10px;
      top: -96px;
      width: 35px;
      z-index: 100;
      box-shadow: 0 0 5px rgba(0, 0, 0, 0.35);
      -moz-box-shadow: 0 0 5px rgba(0,0,0,0.35);
      -webkit-box-shadow: 0 0 5px rgba(0, 0, 0, 0.35);
      -ms-filter: 'progid:DXImageTransform.Microsoft.Shadow(Color=#e5e5e5,direction=120,strength=3)';
      filter: progid:DXImageTransform.Microsoft.Shadow(Color=#e5e5e5,direction=120,strength=3);
      -webkit-border-bottom-right-radius: 5px;
      -webkit-border-bottom-left-radius: 5px;
      -moz-border-radius-bottomright: 5px;
      -moz-border-radius-bottomleft: 5px;
      border-bottom-right-radius: 5px;
      border-bottom-left-radius: 5px;
      border-width: 3px;
      border-style: solid;
    }
    a#message_bar_close, a#message_bar_close:link, a#message_bar_close:visited {
      background-image: url(http://assets-hellobar-com.s3.amazonaws.com/system/modules/hellobar/lib/sprite-8bit.png);
      background-position: 0 58px;
      display: block;
      height: 0;
      overflow: hidden;
      padding: 19px 0 0 0;
      position: absolute;
      right: 20px;
      top: 6px;
      width: 18px;
      z-index: 10;
      border: none;
    }")