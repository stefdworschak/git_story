# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

git_compare =(original_pre, new_pre) ->
  original = original_pre.innerText.split('\n');
  new_content = new_pre.innerHTML.split('\n');
  removed_lines = []
  new_text = ['<pre id="highlighted-content">']
  looper = true
  idx = 0
  while looper == true
    removed_lines = []
    if original[0] == new_content[0]
      new_text.push(original[0] + '\n')
      original.shift()
      new_content.shift();
    else
      if new_content.length > 0
        while new_content[0] != original[0]
          new_text.push("<span style='background:#90ee90;'>+" + new_content[0] + "</span>\n")
          new_content.shift();

          if original.length > 0 && new_content[0] != original[0]
            removed_lines.push("<span style='background:#ee90a9;'>-" + original[0] + "</span>\n")
            original.shift();
        
        new_text = new_text.concat(removed_lines); 
      else 
        while original.length > 0
          new_text.push("<span style='background:#ee90a9;'>-" + original[0] + "</span>\n")
          original.shift();
    
    if original.length == 0 && new_content.length==0 || idx > 50
      looper = false;
    
    idx++;
  new_text.push('</pre>')
  return new_text.join('')


$(document).on 'turbolinks:load', () =>
  count = 1;
  timer = null
  start_node = $('#highlighted-content')
  content_tabs = $('.content')

  $('#stop').on 'click', (event) =>
    clearTimeout(timer)

  $('#play').on 'click', (event) => 
    transition = (node) =>
      playlist_items = $('#playlist > a')
      $('.highlighed_link').removeClass('highlighed_link')
      $(playlist_items[count]).css('font-weight','bold')
      $(playlist_items[count-1]).css('font-weight','normal')

      new_content = git_compare(content_tabs[count-1], content_tabs[count])
      old_node = $('#highlighted-content')
      old_node.removeAttr('id')
      new_node = $('.content-display').append(new_content)
      new_node.fadeIn('fast')
      $(old_node).hide()
      if count < playlist_items.length-1
        timer = setTimeout ->
          count++
          transition(content_tabs[count])
        , 5000
    transition(start_node)