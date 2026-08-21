(function() {
    "use strict";

    function contextPath() {
        return document.body.getAttribute("data-context-path") || "";
    }

    function element(id) {
        return document.getElementById(id);
    }

    function value(id, val) {
        var el = element(id);

        if (!el) {
            return;
        }

        if (arguments.length === 1) {
            return el.value;
        }

        el.value = val == null ? "" : val;
    }

    function initTabs() {
        var root = document.querySelector(".admin-static-page");

        if (!root) {
            return;
        }

        var tabs = root.querySelectorAll("[data-section-target]");
        var sections = root.querySelectorAll("[data-admin-section]");

        for (var i = 0;i < tabs.length;i++) {
            tabs[i].addEventListener("click", function() {
                var target = this.getAttribute("data-section-target");

                for (var j = 0;j < tabs.length;j++) {
                    tabs[j].classList.remove("active");
                }

                for (var k = 0;k < sections.length;k++) {
                    if (sections[k].getAttribute("data-admin-section") === target) {
                        sections[k].hidden = false;
                        sections[k].classList.add("active");
                    } else {
                        sections[k].hidden = true;
                        sections[k].classList.remove("active");
                    }
                }

                this.classList.add("active");
            });
        }

        // ?tab=2 이면 회원 제재 목록 탭 자동으로 열기
        var requestedTab =
            new URLSearchParams(window.location.search).get("tab");

        if (requestedTab !== null) {
            for (var t = 0;t < tabs.length;t++) {
                if (
                    tabs[t].getAttribute("data-section-target")
                    === requestedTab
                ) {
                    tabs[t].click();
                    break;
                }
            }
        }
    }

    function openMemberModal(button) {
        var modal = element("memberModal");
        var form = element("memberForm");

        if (!modal || !form) {
            return;
        }

        form.reset();

        var title = element("memberModalTitle");
        var password = element("memberPassword");
        var passwordMark = element("passwordRequiredMark");
        var passwordHelp = element("passwordHelp");
        var userId = element("memberUserId");

        // 회원 등록
        if (!button) {
            form.action =
                contextPath() + "/admin/member/write";

            form.dataset.originalStatus = "일반";

            title.textContent = "회원 등록";

            value("memberId", "");
            value("memberUserId", "");
            value("memberPassword", "");
            value("memberRole", "1");
            value("memberStatus", "일반");

            userId.readOnly = false;

            password.required = true;
            passwordMark.style.display = "";
            passwordHelp.textContent =
                "신규 등록 시 필수입니다.";
        }

        // 회원 수정
        else {
            form.action =
                contextPath() + "/admin/member/update";

            form.dataset.originalStatus =
                button.dataset.status || "일반";

            title.textContent = "회원 수정";

            value("memberId", button.dataset.memberId);
            value("memberUserId", button.dataset.userId);
            value("memberName", button.dataset.name);
            value("memberEmail", button.dataset.email);
            value("memberPhone", button.dataset.phone);
            value("memberBirth", button.dataset.birth);
            value("memberRole", button.dataset.role);
            value("memberStatus", button.dataset.status);
            value("memberZip", button.dataset.zip);
            value("memberAddr1", button.dataset.addr1);
            value("memberAddr2", button.dataset.addr2);
            value("memberBankName", button.dataset.bankName);
            value(
                "memberRefundAccount",
                button.dataset.refundAccount
            );
            value(
                "memberAccountHolder",
                button.dataset.accountHolder
            );

            value("memberPassword", "");

            userId.readOnly = true;

            password.required = false;
            passwordMark.style.display = "none";
            passwordHelp.textContent =
                "변경할 때만 입력하세요.";
        }

        modal.hidden = false;
        modal.classList.add("show");
        modal.setAttribute("aria-hidden", "false");

        document.body.classList.add(
            "admin-modal-open"
        );
    }

    function closeMemberModal() {
        var modal = element("memberModal");

        if (!modal) {
            return;
        }

        modal.classList.remove("show");
        modal.hidden = true;
        modal.setAttribute("aria-hidden", "true");

        document.body.classList.remove(
            "admin-modal-open"
        );
    }

    function bindCrud() {
        // 회원 등록
        var addButton = element("addMemberButton");

        if (addButton) {
            addButton.addEventListener(
                "click",
                function() {
                    openMemberModal(null);
                }
            );
        }

        // 모달 X 버튼
        var closeButton =
            element("memberModalClose");

        if (closeButton) {
            closeButton.addEventListener(
                "click",
                function() {
                    closeMemberModal();
                }
            );
        }

        // 취소 버튼
        var cancelButton =
            element("memberModalCancel");

        if (cancelButton) {
            cancelButton.addEventListener(
                "click",
                function() {
                    closeMemberModal();
                }
            );
        }

        // 회원 수정 버튼
        document.addEventListener(
            "click",
            function(e) {
                var editButton =
                    e.target.closest(".edit-member");

                if (!editButton) {
                    return;
                }

                e.preventDefault();

                openMemberModal(editButton);
            }
        );

        // 회원 삭제
        var deleteButtons =
            document.querySelectorAll(
                ".delete-member"
            );

        for (
            var d = 0;
            d < deleteButtons.length;
            d++
        ) {
            deleteButtons[d].addEventListener(
                "click",
                function() {
                    var memberId =
                        this.dataset.memberId;

                    var memberName =
                        this.dataset.memberName
                        || "선택한 회원";

                    if (
                        !window.confirm(
                            memberName
                            + " 회원을 삭제할까요?"
                        )
                    ) {
                        return;
                    }

                    value(
                        "deleteMemberId",
                        memberId
                    );

                    var form =
                        element(
                            "memberDeleteForm"
                        );

                    if (form) {
                        form.submit();
                    }
                }
            );
        }

        // 회원 복구
        var restoreButtons =
            document.querySelectorAll(
                ".restore-member"
            );

        for (
            var r = 0;
            r < restoreButtons.length;
            r++
        ) {
            restoreButtons[r].addEventListener(
                "click",
                function() {
                    var memberId =
                        this.dataset.memberId;

                    var memberName =
                        this.dataset.memberName
                        || "선택한 회원";

                    if (
                        !window.confirm(
                            memberName
                            + " 회원을 복구할까요?"
                        )
                    ) {
                        return;
                    }

                    value(
                        "restoreMemberId",
                        memberId
                    );

                    var form =
                        element(
                            "memberRestoreForm"
                        );

                    if (form) {
                        form.submit();
                    }
                }
            );
        }
    }

    function bindAddressSearch() {
        var button =
            element("memberFindAddressBtn");

        if (!button) {
            return;
        }

        button.addEventListener(
            "click",
            function() {
                if (
                    !window.daum
                    || !window.daum.Postcode
                ) {
                    alert(
                        "주소 검색 서비스를 불러오지 못했습니다."
                    );

                    return;
                }

                new window.daum.Postcode({
                    oncomplete: function(data) {
                        var address = "";

                        if (
                            data.userSelectedType
                            === "R"
                        ) {
                            address =
                                data.roadAddress;
                        } else {
                            address =
                                data.jibunAddress;
                        }

                        value(
                            "memberZip",
                            data.zonecode
                        );

                        value(
                            "memberAddr1",
                            address
                        );

                        var detailAddress =
                            element(
                                "memberAddr2"
                            );

                        if (detailAddress) {
                            detailAddress.focus();
                        }
                    }
                }).open();
            }
        );
    }

    function showMessage() {
        var message =
            element("memberResultMessage");

        if (!message) {
            return;
        }

        var text =
            message.getAttribute(
                "data-message"
            );

        if (text) {
            alert(text);
        }
    }

    function bindSanctionSelection() {

        var checkAll =
            element("sanctionCheckAll");

        var rowChecks =
            document.querySelectorAll(
                ".sanction-row-check"
            );

        var selectedCount =
            element("sanctionSelectedCount");

        var deleteButton =
            element("deleteSelectedSanctions");

        var deleteForm =
            element("sanctionDeleteForm");

        if (
            !checkAll ||
            !selectedCount ||
            !deleteButton ||
            !deleteForm
        ) {
            return;
        }

        function updateSelection() {

            var count = 0;

            for (
                var i = 0;
                i < rowChecks.length;
                i++
            ) {
                if (rowChecks[i].checked) {
                    count++;
                }
            }

            selectedCount.textContent =
                String(count);

            deleteButton.disabled =
                count === 0;

            checkAll.checked =
                rowChecks.length > 0 &&
                count === rowChecks.length;

            checkAll.indeterminate =
                count > 0 &&
                count < rowChecks.length;
        }

        // 전체 선택
        checkAll.addEventListener(
            "change",
            function() {

                for (
                    var i = 0;
                    i < rowChecks.length;
                    i++
                ) {
                    rowChecks[i].checked =
                        checkAll.checked;
                }

                updateSelection();
            }
        );

        // 개별 선택
        for (
            var r = 0;
            r < rowChecks.length;
            r++
        ) {

            rowChecks[r].addEventListener(
                "change",
                updateSelection
            );
        }

        // 선택 삭제
        deleteButton.addEventListener(
            "click",
            function() {

                var selected = [];

                for (
                    var i = 0;
                    i < rowChecks.length;
                    i++
                ) {

                    if (rowChecks[i].checked) {
                        selected.push(
                            rowChecks[i]
                                .getAttribute(
                                    "data-sanction-id"
                                )
                        );
                    }
                }

                if (selected.length === 0) {

                    alert(
                        "삭제할 제재를 선택해 주세요."
                    );

                    return;
                }

                if (
                    !confirm(
                        "선택한 "
                        + selected.length
                        + "건의 제재 이력을 삭제하시겠습니까?"
                    )
                ) {
                    return;
                }

                // 기존 hidden 값 제거
                deleteForm.innerHTML = "";

                // 선택된 제재번호를 POST로 전송
                for (
                    var j = 0;
                    j < selected.length;
                    j++
                ) {
                    var input =
                        document.createElement(
                            "input"
                        );
                    input.type = "hidden";
                    input.name = "sanctionIds";
                    input.value = selected[j];

                    deleteForm.appendChild(
                        input
                    );
                }
                deleteForm.submit();
            }
        );
        updateSelection();
    }
	

    function showAdminModal(id) {
        var modal = element(id);
        if (!modal) {
            return;
        }
        modal.hidden = false;
        modal.classList.add("show");
        modal.setAttribute("aria-hidden", "false");
        document.body.classList.add("admin-modal-open");
    }

    function hideAdminModal(id) {
        var modal = element(id);
        if (!modal) {
            return;
        }
        modal.classList.remove("show");
        modal.hidden = true;
        modal.setAttribute("aria-hidden", "true");
        document.body.classList.remove("admin-modal-open");
    }

    function bindPointManagement() {
        var buttons = document.querySelectorAll(".adjust-point");
        for (var i = 0; i < buttons.length; i++) {
            buttons[i].addEventListener("click", function() {
                value("pointMemberId", this.dataset.memberId);
                value("pointAmount", "");
                value("pointReason", "");
                value("pointType", "적립");

                var info = element("pointMemberInfo");
                if (info) {
                    info.textContent =
                        (this.dataset.memberName || "회원")
                        + " / 현재 "
                        + (this.dataset.balance || "0")
                        + "P";
                }
                showAdminModal("pointModal");
            });
        }

        var close = element("pointModalClose");
        var cancel = element("pointModalCancel");
        if (close) {
            close.addEventListener("click", function() {
                hideAdminModal("pointModal");
            });
        }
        if (cancel) {
            cancel.addEventListener("click", function() {
                hideAdminModal("pointModal");
            });
        }
    }

    function bindPointHistoryModal() {
        var modal = element("pointHistoryModal");

        if (!modal) {
            return;
        }

        if (modal.getAttribute("data-auto-open") === "true") {
            showAdminModal("pointHistoryModal");
        }

        function closeHistory() {
            hideAdminModal("pointHistoryModal");

            if (window.history && window.history.replaceState) {
                var url = new URL(window.location.href);
                url.searchParams.delete("pointHistoryMemberId");
                window.history.replaceState({}, "", url.toString());
            }
        }

        var close = element("pointHistoryModalClose");
        var cancel = element("pointHistoryModalCancel");

        if (close) {
            close.addEventListener("click", closeHistory);
        }

        if (cancel) {
            cancel.addEventListener("click", closeHistory);
        }
    }

    function openCouponModal(button) {
        var form = element("couponForm");
        if (!form) {
            return;
        }
        form.reset();

        if (button) {
            form.action = contextPath() + "/admin/member/couponUpdate";
            element("couponModalTitle").textContent = "쿠폰 수정";
            value("couponId", button.dataset.couponId);
            value("couponName", button.dataset.name);
            value("couponValidDays", button.dataset.validDays);
            value("couponDiscount", button.dataset.discount);
            value("couponDiscountType", button.dataset.discountType);
            value("couponMinOrderAmount", button.dataset.minOrderAmount);
            value("couponMaxDiscountAmount", button.dataset.maxDiscountAmount);
            value("couponAvailability", button.dataset.availability);
        } else {
            form.action = contextPath() + "/admin/member/couponWrite";
            element("couponModalTitle").textContent = "쿠폰 등록";
            value("couponId", "");
        }

        showAdminModal("couponModal");
    }

    function bindCouponManagement() {
        var add = element("addCouponButton");
        if (add) {
            add.addEventListener("click", function() {
                openCouponModal(null);
            });
        }

        var edits = document.querySelectorAll(".edit-coupon");
        for (var i = 0; i < edits.length; i++) {
            edits[i].addEventListener("click", function() {
                openCouponModal(this);
            });
        }

        var deletes = document.querySelectorAll(".delete-coupon");
        for (var d = 0; d < deletes.length; d++) {
            deletes[d].addEventListener("click", function() {
                var name = this.dataset.couponName || "선택한 쿠폰";
                if (!window.confirm(name + " 쿠폰을 삭제하시겠습니까?")) {
                    return;
                }
                value("deleteCouponId", this.dataset.couponId);
                var form = element("couponDeleteForm");
                if (form) {
                    form.submit();
                }
            });
        }

        var issues = document.querySelectorAll(".issue-coupon");
        for (var j = 0; j < issues.length; j++) {
            issues[j].addEventListener("click", function() {
                value("issueCouponId", this.dataset.couponId);
                value("issueMemberId", "");
                var info = element("couponIssueInfo");
                if (info) {
                    info.textContent =
                        (this.dataset.couponName || "쿠폰")
                        + "을 발급할 회원번호를 입력해 주세요.";
                }
                showAdminModal("couponIssueModal");
            });
        }

        var close = element("couponModalClose");
        var cancel = element("couponModalCancel");
        if (close) {
            close.addEventListener("click", function() {
                hideAdminModal("couponModal");
            });
        }
        if (cancel) {
            cancel.addEventListener("click", function() {
                hideAdminModal("couponModal");
            });
        }

        var issueClose = element("couponIssueModalClose");
        var issueCancel = element("couponIssueModalCancel");
        if (issueClose) {
            issueClose.addEventListener("click", function() {
                hideAdminModal("couponIssueModal");
            });
        }
        if (issueCancel) {
            issueCancel.addEventListener("click", function() {
                hideAdminModal("couponIssueModal");
            });
        }
    }

    function openFaqModal(button) {
        var form = element("faqForm");
        if (!form) {
            return;
        }
        form.reset();

        if (button) {
            form.action = contextPath() + "/admin/member/faqUpdate";
            element("faqModalTitle").textContent = "FAQ 수정";
            value("faqId", button.dataset.faqId);
            value("faqTitle", button.dataset.title);
            value("faqCategory", button.dataset.category);
            value("faqContent", button.dataset.content);
        } else {
            form.action = contextPath() + "/admin/member/faqWrite";
            element("faqModalTitle").textContent = "FAQ 등록";
            value("faqId", "");
        }

        showAdminModal("faqModal");
    }

    function bindFaqManagement() {
        var add = element("addFaqButton");
        if (add) {
            add.addEventListener("click", function() {
                openFaqModal(null);
            });
        }

        var edits = document.querySelectorAll(".edit-faq");
        for (var i = 0; i < edits.length; i++) {
            edits[i].addEventListener("click", function() {
                openFaqModal(this);
            });
        }

        var deletes = document.querySelectorAll(".delete-faq");
        for (var d = 0; d < deletes.length; d++) {
            deletes[d].addEventListener("click", function() {
                var title = this.dataset.faqTitle || "선택한 FAQ";
                if (!window.confirm(title + " FAQ를 삭제하시겠습니까?")) {
                    return;
                }
                value("deleteFaqId", this.dataset.faqId);
                var form = element("faqDeleteForm");
                if (form) {
                    form.submit();
                }
            });
        }

        var close = element("faqModalClose");
        var cancel = element("faqModalCancel");
        if (close) {
            close.addEventListener("click", function() {
                hideAdminModal("faqModal");
            });
        }
        if (cancel) {
            cancel.addEventListener("click", function() {
                hideAdminModal("faqModal");
            });
        }
    }

	function init() {
		initTabs();
		bindCrud();
		bindAddressSearch();
		bindSanctionSelection();
        bindPointManagement();
        bindPointHistoryModal();
        bindCouponManagement();
        bindFaqManagement();
		showMessage();
	}

    if (
        document.readyState === "loading"
    ) {
        document.addEventListener(
            "DOMContentLoaded",
            init
        );
    } else {
        init();
    }
})();