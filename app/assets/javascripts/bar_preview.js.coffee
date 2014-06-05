class BarPreviewView
  constructor: () ->
    @initialize_bar_preview_events()

  initialize_bar_preview_events: () ->

    $('input').ready -> 
      $('input').trigger('change')
      $('input').trigger('keyup')

    $("#message_bar_link").on 'click', -> 
      return false

    $('#bar_message').on 'keyup', -> 
      $('#message_bar_message').text $(@).val()

    $('#bar_link_text').on 'keyup', -> 
      $('#message_bar_link').text $(@).val()

    $('#bar_setting_attributes_bar_color').on 'change', -> 
      $('#message_bar').css 
        background: $(@).val()  

    $('#bar_setting_attributes_text_color').on 'change', -> 
      $('#message_bar_message').css 
        color: $(@).val()  
        
    $('#bar_setting_attributes_link_color').on 'change', -> 
      $('#message_bar_link').css 
        color: $(@).val()          


window.BarPreviewView = BarPreviewView

$ -> 
  new BarPreviewView()