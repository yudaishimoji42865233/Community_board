//      Pop Easy | jQuery Modal Plugin
//      Version 1.0
//      Created 2013 by Thomas Grauer
///////////////////////////////////////////////////////////////////////////////////////
//      Permission is hereby granted, free of charge, to any person obtaining
//      a copy of this software and associated documentation files (the
//      "Software"), to deal in the Software without restriction, including
//      without limitation the rights to use, copy, modify, merge, publish,
//      distribute, sublicense, and/or sell copies of the Software, and to
//      permit persons to whom the Software is furnished to do so, subject to
//      the following conditions:
//
//      The above copyright notice and this permission notice shall be
//      included in all copies or substantial portions of the Software.
//
//      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//      EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//      MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//      NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//      LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//      OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//      WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
///////////////////////////////////////////////////////////////////////////////////////


(function($){

  $.fn.modal= function(options){
      options = $.extend({
          trigger: '.modalLink',
          olay: 'div.overlay',
          modals: 'div.modal',
          animationEffect: 'slidedown',
          animationSpeed: 400,
          moveModalSpeed: 'slow',
          background: '000',
          opacity: 0.8,
          openOnLoad: false,
          docClose: false,
          closeByEscape: true,
          moveOnScroll: true,
          resizeWindow: true,
          video:'',
          videoClass:'video',
          close:'.closeBtn',
          imlink:'../ibbs_img/'
      },options);
     
      var olay = $(options.olay);
      var modals = $(options.modals);
      var currentModal;
      var isopen=false;
      var mess;
      var iop=0;
      var idelay=0;
      var isfade=1;

      if (options.animationEffect==='fadein'){options.animationEffect = 'fadeIn';}
      if (options.animationEffect==='slidedown'){options.animationEffect = 'slideDown';}
      
      olay.css({opacity : 0});
              
      if(options.openOnLoad) {
          openModal();
      }else{
          olay.hide();
          modals.hide();
      }


  $(".cs1").bind('click', function(e){
          e.preventDefault();
          if(iop==1){
      $("#come").stop(true,true).css({ opacity:0 });
    }
  });
      $(options.trigger).bind('click', function(e){
          e.preventDefault();

    isfade=1;
    getModal = $(this).attr('href');
    param = getModal.split(",");
    var mode=0;
    if( typeof param[1] !== 'undefined' ){
      mode=param[1];
    }

    currentModal = $(param[0]);

    getMess = $(this).attr('id');
    if( typeof getMess !== 'undefined' ){

      mess = getMess.split(",");
      //onloadイベントハンドラ追加

      var tno = 0;
      
      if(mode>0){
        if(mode==1){
          tno = $('#next_no').val();
        }else{
          tno = idx[ idx[$('#next_no').val()]['befo'] ]['befo'];
        }
      }else{
        tno = mess[0];
      }
      $('#next_no').val(idx[tno]['next']);

      var topic_id = $('#topic_id_'+tno).val();
      var url;
      
      if( idx[tno]['img']==1 ){
        url = topic_id;
        iop=1;
      }else{
        url = "/assets/px1.png";
        iop=0;
      }
      var imgPreloader=new Image();

      if(( mode==1 && idx[idx[tno]['befo']]['img']==0 ) || ( mode==2 && idx[idx[tno]['next']]['img']==0 ) ){
        isfade=0;
      }


      imgPreloader.onload=function() {
        //ロード完了で画像を表示
        //../ibbs_img/{$topic_id}_0.jpeg
        $('#pcross').attr('src', url);
      }
      //重要、最後に書く
      imgPreloader.src=url;
      
      //名前
      var pcname="";
      pcname = $('#n_'+tno).html() + "<br>";
      $("#come").css({'text-indent':'-1em','padding-left':'1em','padding-top':''});

      //メッセージ
      $("#come").html( pcname+$('#td_'+tno).html() );
      idelay=1500+$('#td_'+tno).html().length*50;
    }

          openModal();

    var huga = 0;
    var timer1 = setInterval(function() {
      huga++;
      //終了条件
      if (huga == 2) {
        var mtop=$(window).scrollTop();
        if(currentModal.outerHeight()<window.innerHeight){
          mtop=mtop + window.innerHeight /2 - currentModal.outerHeight() /2;
        }

        modals.animate({
          top:mtop
          /*,left:$(window).width() /2 - modals.outerWidth() /2 + $(window).scrollLeft()*/
        },"fast");
        clearInterval(timer1);
      }
    }, 50);

    //.stop(true);

      });
      
      function openModal(){
          $('.' + options.videoClass).attr('src',options.video);
          modals.hide();
          var mtop=$(window).scrollTop();
          if(currentModal.outerHeight()<window.innerHeight){
            mtop=mtop + window.innerHeight /2 - currentModal.outerHeight() /2;
          }
          
          currentModal.css({
              top:mtop
              /*,left:$(window).width() /2 - currentModal.outerWidth() /2 + $(window).scrollLeft()*/
          });
              
          if(isopen===false){
            if( typeof win_h !== 'undefined')$(".cs1").height(win_h);
              olay.css({opacity : options.opacity, backgroundColor: '#'+options.background});
              olay[options.animationEffect](options.animationSpeed);
              currentModal.delay(options.animationSpeed)[options.animationEffect](options.animationSpeed);
              $("#come").stop(true).animate({ opacity:1 }, 1000).delay(idelay).animate({ opacity:0 }, 1000);
          }else{
              currentModal.show();
              if( typeof win_h !== 'undefined')$(".cs1").height(win_h);
              if(isfade==1){
                $("#pcross").stop(true,true).css({ opacity:0 }).animate({ opacity:1 }, 500);
              }else{
                $("#pcross").stop(true,true).css({ opacity:1 });
              }
              if(iop==1){
                $("#come").stop(true,true).css({ opacity:0 }).animate({ opacity:1 }, 500).delay(idelay).animate({ opacity:0 }, 1000);
              }else{
                $("#come").stop(true,true).css({ opacity:0 }).animate({ opacity:1 }, 500);
              }
          }

          isopen=true;
      }
      
      function moveModal(){
          modals
          .stop(true)
          .animate({
          top:window.innerHeight /2 - modals.outerHeight() /2 + $(window).scrollTop()
          /*,left:$(window).width() /2 - modals.outerWidth() /2 + $(window).scrollLeft()*/
          },options.moveModalSpeed);
      }
      
      function closeModal(){
          $('.' + options.videoClass).attr('src',''); 
          isopen=false;
          modals.fadeOut(100, function(){
              if (options.animationEffect === 'slideDown') {
                  olay.slideUp();
              }else if (options.animationEffect === 'fadeIn') {
                  olay.fadeOut();
              }
          });
          return false;
      }
      
      if(options.docClose){
          olay.bind('click', closeModal);
      }
      
      $(options.close).bind('click', closeModal);
      
      if (options.closeByEscape) {
          $(window).bind('keyup', function(e){
              if(e.which === 27){
                  closeModal();
              }
          });
      }
      
      if (options.resizeWindow) {
          $(window).bind('resize', moveModal);
      }else{
          return false;
      }
      
      if (options.moveOnScroll) {
          $(window).bind('scroll', moveModal);
      }else{
          return false;
      }
  };
})(jQuery);
