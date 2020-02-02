$(document).ready(function(){
  $('.modalLink').modal({
      trigger: '.modalLink',          // id or class of link or button to trigger modal
      olay:'div.overlay',             // id or class of overlay
      modals:'div.modal',             // id or class of modal
      animationEffect: 'fadeIn',   // overlay effect | slideDown or fadeIn | default=fadeIn
      animationSpeed: 100,            // speed of overlay in milliseconds | default=400
      moveModalSpeed: 'fast',         // speed of modal movement when window is resized | slow or fast | default=false
      background: '000',           // hexidecimal color code - DONT USE #
      opacity: 0.5,                   // opacity of modal |  0 - 1 | default = 0.8
      openOnLoad: false,              // open modal on page load | true or false | default=false
      docClose: true,                 // click document to close | true or false | default=true    
      closeByEscape: true,            // close modal by escape key | true or false | default=true
      moveOnScroll: false,             // move modal when window is scrolled | true or false | default=false
      resizeWindow: true,             // move modal when window is resized | true or false | default=false
      video: '',                      // enter the url of the video
      videoClass:'video',             // class of video element(s)
      close:'.closeBtn'               // id or class of close button
  });
});

function comeDelete(delno){
	document.form_del_come.del_come.value=delno;
	document.form_del_come.submit();
}
