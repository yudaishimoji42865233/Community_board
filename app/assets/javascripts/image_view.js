$(function() {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
        $('#input_form_topic').html(`<input name="topic[remove_image]" type="hidden" value="0"><input type="checkbox" value="1" name="topic[remove_image]" id="topic_remove_image"><span class="small bold">画像を削除する（投稿後に反映されます）</span>`);
        $('#input_form_edit').html(`<span class="small bold">画像の削除は次の投稿確認画面で可能です</span>`);
        $('#input_form_comment').html(`<input type="checkbox" value="1" name="comment[remove_image]" id="comment_remove_image"><span class="small bold">画像を削除する（投稿後に反映されます）</span>`);
        $('#input_form_user').html(`<input type="checkbox" value="1" name="user[remove_image]" id="user_remove_image"><span class="small bold">画像を削除する（登録後に反映されます）</span>`);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $("#topic_image").change(function(){
    readURL(this);
  });
 });