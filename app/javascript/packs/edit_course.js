$(document).on("click", ".delete-lesson-btn", function () {
  btn_delete_lesson = $(this);
  $('#confirm-delete').on('shown.bs.modal', function() {
    delete_modal = $(this);
    $(document).on("click", ".btn-ok", function () {
      btn_delete_lesson.parent().find(".delete-lesson").val("true");
      btn_delete_lesson.closest(".lesson-box").hide();
      delete_modal.modal('hide');
    })
  });
})

$(document).on("click", ".delete-question-btn", function () {
  btn_delete = $(this);
  $('#confirm-delete').on('shown.bs.modal', function() {
    confirm_modal = $(this);
    $(document).on("click", ".btn-ok", function () {
      btn_delete.parent().find(".delete-question").val("true");
      btn_delete.parent().hide();
      confirm_modal.modal('hide');
    })
  });
})

$(document).on("click", ".btn-edit-course", function () {
  $("#sortable").find(".lesson-box").filter(function () {
    return $(this).find(".delete-lesson").val() == "false"
  }).each(function (index) {
    $(this).find(".lesson_seq").val(index + 1);
  })
  $(this).submit();
})
