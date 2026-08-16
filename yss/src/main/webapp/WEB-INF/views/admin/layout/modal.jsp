<%@ page contentType="text/html; charset=UTF-8" %>

<div class="modal-backdrop" id="editModal" aria-hidden="true" hidden>
  <section class="admin-modal" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
    <div class="modal-head">
      <div>
        <p id="modalGuide">상태 항목은 선택해서 변경할 수 있습니다.</p>
        <h2 id="modalTitle">신규 등록</h2>
      </div>
      <button type="button" class="modal-close" id="modalClose" aria-label="닫기">×</button>
    </div>
    <form name="editForm" id="editForm"  method="post" enctype="mutipart/form-data"
    action="${pageContext.request.contextPath}/admin/product/write">
      <div class="form-grid" id="formFields"></div>
      <div class="modal-actions">
        <button type="button" class="light-btn" id="modalCancel">취소</button>
        <button type="button" class="primary-btn" onclick="sendOk()">저장</button>
      </div>
    </form>
  </section>
</div>

<div class="modal-backdrop" id="answerModal" aria-hidden="true" hidden>
  <section class="admin-modal answer-modal" role="dialog" aria-modal="true" aria-labelledby="answerModalTitle">
    <div class="modal-head">
      <div>
        <p id="answerModalGuide">고객 문의 답변</p>
        <h2 id="answerModalTitle">답변 등록</h2>
      </div>
      <button type="button" class="modal-close" id="answerModalClose" aria-label="닫기">×</button>
    </div>

    <div class="inquiry-box">
      <div><span>문의번호</span><strong id="answerQuestionNumber">-</strong></div>
      <div><span>작성자</span><strong id="answerWriter">-</strong></div>
      <div class="wide"><span>문의 제목</span><strong id="answerQuestionTitle">-</strong></div>
      <div class="wide"><span>문의 내용</span><p id="answerQuestionContent">-</p></div>
    </div>

    <form id="answerForm">
      <label class="answer-label" for="answerText">답변 내용 <b>*</b></label>
      <textarea id="answerText" maxlength="1000" placeholder="고객에게 전달할 답변을 입력하세요." required></textarea>
      <div class="answer-count"><span id="answerCount">0</span> / 1000자</div>
      <div class="modal-actions answer-actions">
        <button type="button" class="light-btn danger-btn" id="answerDelete">답변 삭제</button>
        <div>
          <button type="button" class="light-btn" id="answerCancel">취소</button>
          <button type="submit" class="primary-btn" id="answerSave">답변 등록</button>
        </div>
      </div>
    </form>
  </section>
</div>

<div class="confirm-backdrop" id="confirmBox" aria-hidden="true" hidden>
  <section class="confirm-box" role="alertdialog" aria-modal="true">
    <h3 id="confirmTitle">선택한 항목을 삭제할까요?</h3>
    <p id="confirmText">화면의 예시 데이터에서 삭제됩니다.</p>
    <div>
      <button type="button" class="light-btn" id="confirmCancel">취소</button>
      <button type="button" class="dark-btn danger-solid" id="confirmOk">삭제</button>
    </div>
  </section>
</div>

<div class="toast" id="toast">검색 결과를 갱신했습니다.</div>
