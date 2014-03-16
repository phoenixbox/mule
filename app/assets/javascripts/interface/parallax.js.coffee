parallaxScroll = () =>
  currentScrollPosition = $(this).scrollTop()
  $('.opening').css
    'background-position' : '50% ' + ( -currentScrollPosition / 4 ) + 'px'
  $('.heroImage').css
    'margin-top' : ( currentScrollPosition / 4 ) + "px"
    'opacity' : 1 - ( currentScrollPosition / 250 )
  $('.headerCopy').css
    'margin-top' : ( currentScrollPosition / 4 ) + "px"
    'opacity' : 1 - ( currentScrollPosition / 250 )
  $('.subheaderCopy').css
    'margin-top' : ( currentScrollPosition / 4 ) + "px"
    'opacity' : 1 - ( currentScrollPosition / 250 )

$(document).ready =>

  $(window).scroll =>
    parallaxScroll()

  $(document).scroll =>
    windowTop = $(window).scrollTop()
    bottomOfOpening = $('.opening').position().top + $('.opening').height()
    header = $('.header')
    sideBar = $('.sideBar')
    windowHeight = $(window).height()
    compareWindowHeight = ( windowHeight - 70 ) + "px"
    if (bottomOfOpening > windowTop)
      header.css
        'position' : 'absolute'
        'top'      : '100%'
        'left'     : '0'
    else
      header.css
        'position' : 'fixed'
        'top'      : '0'
        'left'     : '0'