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
                    if (
                        sections[k].getAttribute("data-admin-section") === target
                    ) {
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
            form.action = contextPath() + "/admin/member/write";

            title.textContent = "회원 등록";

            value("memberId", "");
            value("memberUserId", "");
            value("memberPassword", "");
            value("memberRole", "1");
            value("memberStatus", "일반");

            userId.readOnly = false;

            password.required = true;
            passwordMark.style.display = "";
            passwordHelp.textContent = "신규 등록 시 필수입니다.";
        }

        // 회원 수정
        else {
            form.action = contextPath() + "/admin/member/update";

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
            value("memberRefundAccount", button.dataset.refundAccount);
            value("memberAccountHolder", button.dataset.accountHolder);

            value("memberPassword", "");

            userId.readOnly = true;

            password.required = false;
            passwordMark.style.display = "none";
            passwordHelp.textContent = "변경할 때만 입력하세요.";
        }

        modal.hidden = false;
        modal.setAttribute("aria-hidden", "false");
    }

    function closeMemberModal() {
        var modal = element("memberModal");

        if (!modal) {
            return;
        }

        modal.hidden = true;
        modal.setAttribute("aria-hidden", "true");
    }

    function bindCrud() {
        // 회원 등록 버튼
        var addButton = element("addMemberButton");

        if (addButton) {
            addButton.addEventListener("click", function() {
                openMemberModal(null);
            });
        }

        // 모달 X 버튼
        var closeButton = element("memberModalClose");

        if (closeButton) {
            closeButton.addEventListener("click", function() {
                closeMemberModal();
            });
        }

        // 모달 취소 버튼
        var cancelButton = element("memberModalCancel");

        if (cancelButton) {
            cancelButton.addEventListener("click", function() {
                closeMemberModal();
            });
        }

        // 회원 수정 버튼
        var editButtons = document.querySelectorAll(".edit-member");

        for (var i = 0;i < editButtons.length;i++) {
            editButtons[i].addEventListener("click", function() {
                openMemberModal(this);
            });
        }

        // 회원 삭제 버튼
        var deleteButtons = document.querySelectorAll(".delete-member");

        for (var d = 0;d < deleteButtons.length;d++) {
            deleteButtons[d].addEventListener("click", function() {
                var memberId = this.dataset.memberId;
                var memberName =
                    this.dataset.memberName || "선택한 회원";

                if (
                    !window.confirm(
                        memberName + " 회원을 삭제할까요?"
                    )
                ) {
                    return;
                }

                value("deleteMemberId", memberId);

                var form = element("memberDeleteForm");

                if (form) {
                    form.submit();
                }
            });
        }

        // 회원 복구 버튼
        var restoreButtons =
            document.querySelectorAll(".restore-member");

        for (var r = 0;r < restoreButtons.length;r++) {
            restoreButtons[r].addEventListener("click", function() {
                var memberId = this.dataset.memberId;
                var memberName =
                    this.dataset.memberName || "선택한 회원";

                if (
                    !window.confirm(
                        memberName + " 회원을 복구할까요?"
                    )
                ) {
                    return;
                }

                value("restoreMemberId", memberId);

                var form = element("memberRestoreForm");

                if (form) {
                    form.submit();
                }
            });
        }
    }

    function bindAddressSearch() {
        var button = element("memberFindAddressBtn");

        if (!button) {
            return;
        }

        button.addEventListener("click", function() {
            if (!window.daum || !window.daum.Postcode) {
                alert("주소 검색 서비스를 불러오지 못했습니다.");
                return;
            }

            new window.daum.Postcode({
                oncomplete: function(data) {
                    var address = "";

                    if (data.userSelectedType === "R") {
                        address = data.roadAddress;
                    } else {
                        address = data.jibunAddress;
                    }

                    value("memberZip", data.zonecode);
                    value("memberAddr1", address);

                    var detailAddress =
                        element("memberAddr2");

                    if (detailAddress) {
                        detailAddress.focus();
                    }
                }
            }).open();
        });
    }

    function showMessage() {
        var message = element("memberResultMessage");

        if (!message) {
            return;
        }

        var text = message.getAttribute("data-message");

        if (text) {
            alert(text);
        }
    }

    function init() {
        initTabs();
        bindCrud();
        bindAddressSearch();
        showMessage();
    }

    if (document.readyState === "loading") {
        document.addEventListener(
            "DOMContentLoaded",
            init
        );
    } else {
        init();
    }
})();