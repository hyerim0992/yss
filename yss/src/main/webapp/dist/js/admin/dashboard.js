(function () {
  "use strict";

  function formatKoreanDate(date) {
    var weekdays = ["일", "월", "화", "수", "목", "금", "토"];
    return date.getFullYear() + "년 " +
      (date.getMonth() + 1) + "월 " +
      date.getDate() + "일 " +
      weekdays[date.getDay()] + "요일";
  }

  function init() {
    var date = document.getElementById("dashboardDate");
    if (date) date.textContent = formatKoreanDate(new Date());
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
