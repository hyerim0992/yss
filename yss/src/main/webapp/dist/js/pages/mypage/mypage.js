document.addEventListener("DOMContentLoaded", () => {
  const $ = (selector, parent = document) => parent.querySelector(selector);
  const $$ = (selector, parent = document) => [
    ...parent.querySelectorAll(selector),
  ];
  const views = $$(".page-view");
  const sidebar = $("#mySidebar");
  const protectedViews = new Set(["profile", "password"]);
  let unlocked = false;
  let pendingView = null;
  let toastTimer;

  function toast(message) {
    $("#toast").textContent = message;
    $("#toast").classList.add("is-show");
    clearTimeout(toastTimer);
    toastTimer = setTimeout(
      () => $("#toast").classList.remove("is-show"),
      2200
    );
  }

  function openModal(id) {
    const modal = $(`#${id}`);
    if (!modal) return;
    modal.classList.add("is-open");
    modal.setAttribute("aria-hidden", "false");
    document.body.style.overflow = "hidden";

    if (id === "passwordGate") {
      const input = $("#gatePassword");
      const help = $("#gateHelp");
      if (input) {
        input.value = "";
        window.setTimeout(() => input.focus(), 0);
      }
      if (help) {
        help.textContent = "UI 확인용 비밀번호는 1234입니다.";
        help.classList.remove("is-error");
      }
    }
  }

  function closeModal(modal) {
    if (!modal) return;
    modal.classList.remove("is-open");
    modal.setAttribute("aria-hidden", "true");
    document.body.style.overflow = "";
  }

  function openPostcodeSearch(button) {
    const postcodeInput = document.getElementById(
      button.dataset.postcodeTarget || ""
    );
    const addressInput = document.getElementById(
      button.dataset.addressTarget || ""
    );
    const detailInput = document.getElementById(
      button.dataset.detailTarget || ""
    );

    if (!postcodeInput || !addressInput || !detailInput) {
      toast("주소 입력 항목을 찾을 수 없습니다.");
      return;
    }

    if (!window.kakao || typeof window.kakao.Postcode !== "function") {
      toast("주소 검색 서비스를 불러오지 못했습니다. 인터넷 연결을 확인해 주세요.");
      return;
    }

    new window.kakao.Postcode({
      oncomplete(data) {
        let address =
          data.userSelectedType === "R" ? data.roadAddress : data.jibunAddress;
        let extraAddress = "";

        if (data.userSelectedType === "R") {
          if (data.bname && /[동로가]$/.test(data.bname)) {
            extraAddress += data.bname;
          }
          if (data.buildingName && data.apartment === "Y") {
            extraAddress += extraAddress
              ? `, ${data.buildingName}`
              : data.buildingName;
          }
        }

        if (extraAddress) address += ` (${extraAddress})`;

        postcodeInput.value = data.zonecode || "";
        addressInput.value = address || data.address || "";
        detailInput.value = "";
        detailInput.focus();
        toast("주소가 입력되었습니다. 상세 주소를 작성해 주세요.");
      },
    }).open({ popupKey: "yongsinsaMypageAddress" });
  }

  function finishSamePageLoading() {
    if (window.YSPageLoader && typeof window.YSPageLoader.hide === "function") {
      window.YSPageLoader.hide();
    }
  }

  function activateView(name, updateHash = false) {
    const next = views.find((view) => view.dataset.page === name) || views[0];
    const nextName = next.dataset.page;
    if (protectedViews.has(nextName) && !unlocked) {
      pendingView = nextName;
      openModal("passwordGate");
      finishSamePageLoading();
      return;
    }
    views.forEach((view) => view.classList.toggle("is-active", view === next));
    $$(".my-sidebar [data-view]").forEach((link) => {
      link.classList.toggle("is-active", link.dataset.view === nextName);
    });
    if (sidebar) {
      sidebar.classList.remove("is-open");
    }
    if (updateHash) history.replaceState(null, "", `#${nextName}`);
    window.scrollTo({ top: 0, behavior: "smooth" });
    finishSamePageLoading();
  }

  function activateHashView() {
    const path = location.pathname;
    let defaultView = "home";

    if (path.indexOf("/wishlist") !== -1) {
      defaultView = "wishlist";
    }

    activateView(location.hash.replace("#", "") || defaultView, false);
  }

  window.YSMypage = {
    activateView(name) {
      activateView(name, false);
    },
  };

  // 🔴 해시 이동 이벤트 제거 (URL 기반 이동 전용)
  // window.addEventListener("hashchange", activateHashView);

  document.addEventListener("yongsinsa:mypage-view", (event) => {
    const viewName = event.detail && event.detail.view;
    if (viewName) activateView(viewName, false);
  });

  document.addEventListener("click", (event) => {
    const viewButton = event.target.closest("[data-view]");
    if (viewButton) {
      // 🔴 event.preventDefault() 제거! 
      // 실제 a 태그 href 주소(/mypage/wishlist 등)로 Controller를 다녀오도록 페이지 이동을 허용합니다.
      return;
    }
    const modalButton = event.target.closest("[data-modal]");
    if (modalButton) {
      event.preventDefault();
      openModal(modalButton.dataset.modal);
      return;
    }
    const modalCloseButton = event.target.closest(".modal-close[data-close-modal]");
    if (modalCloseButton) {
      event.preventDefault();
      event.stopPropagation();
      closeModal(modalCloseButton.closest(".modal"));
      return;
    }

    const actionButton = event.target.closest("[data-action]");
    if (!actionButton) return;
    handleAction(actionButton);
  });

  function handleAction(button) {
    const action = button.dataset.action;

    if (action === "postcode") {
      openPostcodeSearch(button);
      return;
    }

    const messages = {
      search: "검색 Controller를 연결할 위치입니다.",
      filter: "선택한 조건으로 조회했어요.",
      detail: "주문 상세정보를 열었어요.",
      review: "리뷰 작성 화면을 열었어요.",
      "purchase-confirm": "구매가 확정되었습니다.",
      exchange: "교환 신청 화면을 열었어요.",
      return: "반품 신청 화면을 열었어요.",
      refund: "환불 신청 화면을 열었어요.",
      edit: "수정 입력 화면을 열었어요.",
      "coupon-register": "쿠폰 등록창을 열었어요.",
      photo: "프로필 이미지 업로드 연결 위치입니다.",
      "faq-search": "관련 질문을 검색했어요.",
      copy: "운송장 번호를 복사했어요.",
      "default-address": "기본 배송지로 설정했어요.",
      "review-edit": "리뷰 수정 화면을 열었어요.",
    };
    if (action === "delete" && confirm("정말 삭제하시겠어요?"))
      toast("삭제되었습니다.");
    else if (action === "order-cancel" && confirm("주문을 취소하시겠어요?"))
      toast("주문 취소 요청이 접수되었습니다.");
    else if (action === "heart") {
      button.classList.toggle("is-on");
      button.textContent = button.classList.contains("is-on") ? "♥" : "♡";
      toast("위시리스트를 변경했어요.");
    } else if (
      action === "remove-wish" &&
      confirm("위시리스트에서 삭제하시겠어요?")
    ) {
      button.closest("article").remove();
      toast("관심 상품을 삭제했어요.");
    } else if (
      action === "remove-cart" &&
      confirm("장바구니에서 이 상품을 삭제하시겠어요?")
    ) {
      button.closest(".cart-item").remove();
      updateCartTotals();
      toast("장바구니 상품을 삭제했어요.");
    } else if (
      action === "remove-review" &&
      confirm("작성한 리뷰를 삭제하시겠어요?")
    ) {
      button.closest(".review-item").remove();
      toast("리뷰를 삭제했어요.");
    } else if (messages[action]) toast(messages[action]);
  }

  const sidebarToggle = $("#sidebarToggle");
  if (sidebarToggle) {
    sidebarToggle.addEventListener("click", () =>
      sidebar.classList.toggle("is-open")
    );
  }

  $$(".modal-dialog").forEach(function (dialog) {
    ["pointerdown", "mousedown", "touchstart"].forEach(function (eventName) {
      dialog.addEventListener(eventName, function (event) {
        event.stopPropagation();
      });
    });
  });

  $$(".modal-backdrop[data-close-modal]").forEach(function (backdrop) {
    backdrop.addEventListener("click", function (event) {
      if (event.target !== backdrop) return;
      event.preventDefault();
      event.stopPropagation();
      closeModal(backdrop.parentElement);
    });
  });

  const passwordGateForm = $("#passwordGateForm");
  const gatePassword = $("#gatePassword");
  const gateHelp = $("#gateHelp");
  const UI_TEST_PASSWORD = "1234";

  if (passwordGateForm && gatePassword && gateHelp) {
    passwordGateForm.addEventListener("submit", (event) => {
      event.preventDefault();
      event.stopPropagation();
      const password = gatePassword.value.trim();

      if (!password) {
        gateHelp.textContent = "현재 비밀번호를 입력해 주세요.";
        gateHelp.classList.add("is-error");
        gatePassword.focus();
        return;
      }

      if (password !== UI_TEST_PASSWORD) {
        gateHelp.textContent =
          "비밀번호가 일치하지 않습니다. UI 확인용 비밀번호는 1234입니다.";
        gateHelp.classList.add("is-error");
        gatePassword.select();
        return;
      }

      const nextView = pendingView || "profile";
      unlocked = true;

      closeModal($("#passwordGate"));
      activateView(nextView);
      pendingView = null;
      gatePassword.value = "";
      gateHelp.textContent = "UI 확인용 비밀번호는 1234입니다.";
      gateHelp.classList.remove("is-error");
      toast("본인 확인이 완료되었습니다.");
    });

    gatePassword.addEventListener("input", () => {
      gateHelp.textContent = "UI 확인용 비밀번호는 1234입니다.";
      gateHelp.classList.remove("is-error");
    });
  }

  $$(".chip-row").forEach((row) =>
    row.addEventListener("click", (event) => {
      const chip = event.target.closest(".chip");
      if (!chip) return;
      $$(".chip", row).forEach((item) =>
        item.classList.toggle("is-active", item === chip)
      );
      $$(".transaction-item", row.closest(".page-view")).forEach((item) => {
        item.style.display =
          chip.dataset.filter === "all" ||
          item.dataset.status === chip.dataset.filter
            ? ""
            : "none";
      });
    })
  );

  $$(".period-row").forEach((row) =>
    row.addEventListener("click", (event) => {
      const period = event.target.closest(".period");
      if (!period) return;
      $$(".period", row).forEach((item) =>
        item.classList.toggle("is-active", item === period)
      );
    })
  );

  $$("[data-tab-group]").forEach((bar) =>
    bar.addEventListener("click", (event) => {
      const tab = event.target.closest("[data-tab]");
      if (!tab) return;
      const page = bar.closest(".page-view");
      $$("[data-tab]", bar).forEach((item) =>
        item.classList.toggle("is-active", item === tab)
      );
      $$("[data-tab-panel]", page).forEach((panel) =>
        panel.classList.toggle(
          "is-hidden",
          panel.dataset.tabPanel !== tab.dataset.tab
        )
      );
      if (!$(`[data-tab-panel='${tab.dataset.tab}']`, page))
        toast(`${tab.textContent.trim()} 내역을 선택했어요.`);
    })
  );

  $$(".accordion").forEach((button) => {
    button.addEventListener("click", () => {
      button.classList.toggle("is-open");

      if (button.nextElementSibling) {
        button.nextElementSibling.classList.toggle("is-open");
      }
    });
  });

  const faqCategoryButtons = $$("[data-faq-category]");
  const faqItems = $$("[data-faq-item]");
  const faqSearchInput = $("#mypageFaqSearchInput");
  const faqSearchButton = $("#mypageFaqSearchButton");
  const faqEmptyMessage = $("#mypageFaqEmptyMessage");
  let activeFaqCategory = "전체";

  function filterMypageFaq() {
    const keyword = faqSearchInput
      ? faqSearchInput.value.trim().toLowerCase()
      : "";
    let visibleCount = 0;

    faqItems.forEach(function (item) {
      const panel = item.nextElementSibling;
      const category = item.getAttribute("data-category") || "";
      const searchableText = (
        item.textContent + " " + (panel ? panel.textContent : "")
      ).toLowerCase();
      const categoryMatches =
        activeFaqCategory === "전체" || category === activeFaqCategory;
      const keywordMatches = !keyword || searchableText.indexOf(keyword) !== -1;
      const shouldShow = categoryMatches && keywordMatches;

      item.hidden = !shouldShow;
      if (panel && panel.hasAttribute("data-faq-panel")) {
        panel.hidden = !shouldShow;
        if (!shouldShow) {
          item.classList.remove("is-open");
          panel.classList.remove("is-open");
        }
      }

      if (shouldShow) visibleCount += 1;
    });

    if (faqEmptyMessage) {
      faqEmptyMessage.hidden = visibleCount !== 0;
    }
  }

  faqCategoryButtons.forEach(function (button) {
    button.addEventListener("click", function () {
      activeFaqCategory = button.getAttribute("data-faq-category") || "전체";
      faqCategoryButtons.forEach(function (item) {
        item.classList.toggle("is-active", item === button);
      });
      filterMypageFaq();
    });
  });

  if (faqSearchButton) {
    faqSearchButton.addEventListener("click", filterMypageFaq);
  }

  if (faqSearchInput) {
    faqSearchInput.addEventListener("input", filterMypageFaq);
    faqSearchInput.addEventListener("keydown", function (event) {
      if (event.key === "Enter") {
        event.preventDefault();
        filterMypageFaq();
      }
    });
  }

  const wishAll = $("#wishAll");
  if (wishAll) {
    wishAll.addEventListener("change", (event) => {
      $$(".wish-check").forEach((check) => {
        check.checked = event.target.checked;
      });
    });
  }

  const deleteSelectedWish = $("#deleteSelectedWish");
  if (deleteSelectedWish) {
    deleteSelectedWish.addEventListener("click", () => {
      const selected = $$(".wish-check:checked");
      if (!selected.length) return toast("삭제할 상품을 선택해 주세요.");
      if (!confirm(`${selected.length}개 상품을 삭제하시겠어요?`)) return;
      selected.forEach((check) => check.closest("article").remove());
      toast("선택 상품을 삭제했어요.");
    });
  }

  function formatWon(value) {
    return Number(value || 0).toLocaleString("ko-KR") + "원";
  }

  function formatPoint(value) {
    return Number(value || 0).toLocaleString("ko-KR") + "P";
  }

  const CART_AVAILABLE_POINT = 12500;
  const CART_POINT_UNIT = 1000;
  const CART_MAX_USABLE_POINT = Math.floor(CART_AVAILABLE_POINT / CART_POINT_UNIT) * CART_POINT_UNIT;
  let cartCouponCode = "none";
  let cartCouponDiscountValue = 0;
  let cartPointUseValue = 0;
  let cartOptionTarget = null;

  function getCartSelectedData() {
    const selectedItems = $$(".cart-item .cart-check:checked").map(function (check) {
      return check.closest(".cart-item");
    });
    let itemCount = selectedItems.length;
    let quantityCount = 0;
    let productTotal = 0;

    selectedItems.forEach(function (item) {
      const quantityInput = $(".cart-quantity-control input", item);
      const quantity = Math.max(1, Math.min(10, Number(quantityInput.value) || 1));
      const price = Number(item.dataset.price) || 0;
      quantityInput.value = quantity;
      quantityCount += quantity;
      productTotal += price * quantity;
    });

    return {
      items: selectedItems,
      itemCount: itemCount,
      quantityCount: quantityCount,
      productTotal: productTotal,
    };
  }

  function calculateCartCoupon(total, code) {
    if (!total || code === "none") return 0;
    if (code === "welcome5") return Math.min(5000, total);
    if (code === "rate10") return Math.min(Math.floor(total * 0.1), 20000);
    if (code === "fixed15") return total >= 100000 ? 15000 : 0;
    if (code === "season7") return Math.min(Math.floor(total * 0.07), 10000);
    return 0;
  }

  function getCartPointLimit(productTotal, couponDiscount) {
    const payable = Math.max(0, productTotal - couponDiscount);
    return Math.floor(
      Math.min(CART_MAX_USABLE_POINT, payable) / CART_POINT_UNIT
    ) * CART_POINT_UNIT;
  }

  function setCartPointError(message) {
    const error = $("#cartPointError");
    if (!error) return;
    error.textContent = message || "";
    error.classList.toggle("is-visible", Boolean(message));
  }

  function normalizeCartPointInput(showLimitMessage) {
    const input = $("#cartPointInput");
    if (!input) return 0;

    const data = getCartSelectedData();
    const couponSelect = $("#cartCouponSelect");
    const couponCode = couponSelect ? couponSelect.value : cartCouponCode;
    const couponDiscount = calculateCartCoupon(data.productTotal, couponCode);
    const pointLimit = getCartPointLimit(data.productTotal, couponDiscount);
    let pointUse = Number(input.value) || 0;

    if (pointUse < 0) {
      pointUse = 0;
      input.value = 0;
    }

    if (pointUse > pointLimit) {
      input.value = pointLimit;
      pointUse = pointLimit;
      if (showLimitMessage) {
        if (pointLimit === CART_MAX_USABLE_POINT) {
          setCartPointError(
            "보유 포인트가 부족합니다. 최대 " +
              formatPoint(CART_MAX_USABLE_POINT) +
              "까지 사용할 수 있어요."
          );
        } else {
          setCartPointError("결제 예정 금액보다 많은 포인트는 사용할 수 없어요.");
        }
      }
    }

    return pointUse;
  }

  function getCartPreviewValues() {
    const data = getCartSelectedData();
    const couponSelect = $("#cartCouponSelect");
    const pointInput = $("#cartPointInput");
    const previewCouponCode = couponSelect ? couponSelect.value : cartCouponCode;
    const couponDiscount = calculateCartCoupon(data.productTotal, previewCouponCode);
    let pointUse = pointInput ? Number(pointInput.value) || 0 : cartPointUseValue;
    pointUse = Math.max(0, pointUse);
    pointUse = Math.min(
      pointUse,
      getCartPointLimit(data.productTotal, couponDiscount)
    );

    return {
      productTotal: data.productTotal,
      couponDiscount: couponDiscount,
      pointUse: pointUse,
      finalTotal: Math.max(0, data.productTotal - couponDiscount - pointUse),
    };
  }

  function updateCartBenefitPreview() {
    const values = getCartPreviewValues();
    const productTotal = $("#cartBenefitProductTotal");
    const couponDiscount = $("#cartBenefitCouponDiscount");
    const pointDiscount = $("#cartBenefitPointDiscount");
    const finalTotal = $("#cartBenefitFinalTotal");

    if (productTotal) productTotal.textContent = formatWon(values.productTotal);
    if (couponDiscount) couponDiscount.textContent = "-" + formatWon(values.couponDiscount);
    if (pointDiscount) pointDiscount.textContent = "-" + formatPoint(values.pointUse);
    if (finalTotal) finalTotal.textContent = formatWon(values.finalTotal);
  }

  function updateCartTotals() {
    const items = $$(".cart-item");

    items.forEach(function (item) {
      const quantityInput = $(".cart-quantity-control input", item);
      const quantity = Math.max(1, Math.min(10, Number(quantityInput.value) || 1));
      const price = Number(item.dataset.price) || 0;
      const listPrice = Number(item.dataset.listPrice) || price;
      quantityInput.value = quantity;
      $(".cart-price", item).textContent = formatWon(price * quantity);
      $(".cart-list-price", item).textContent = formatWon(listPrice * quantity);
    });

    const data = getCartSelectedData();
    cartCouponDiscountValue = calculateCartCoupon(data.productTotal, cartCouponCode);
    cartPointUseValue = Math.min(
      cartPointUseValue,
      CART_MAX_USABLE_POINT,
      Math.max(0, data.productTotal - cartCouponDiscountValue)
    );

    if (cartPointUseValue > 0) {
      cartPointUseValue = Math.floor(cartPointUseValue / CART_POINT_UNIT) * CART_POINT_UNIT;
    }

    const discountTotal = cartCouponDiscountValue + cartPointUseValue;
    const grandTotal = Math.max(0, data.productTotal - discountTotal);
    const expectedPoint = Math.floor(grandTotal * 0.01);

    const summary = $("#cartSelectedSummary");
    if (summary) {
      summary.textContent =
        "선택 상품 " + data.itemCount + "개 · 총 수량 " + data.quantityCount + "개";
    }

    const cartProdTotal = $("#cartProductTotal");
    if (cartProdTotal) cartProdTotal.textContent = formatWon(data.productTotal);

    const cartDetailProd = $("#cartDetailProduct");
    if (cartDetailProd) cartDetailProd.textContent = formatWon(data.productTotal);

    const cartDiscTotal = $("#cartDiscountTotal");
    if (cartDiscTotal) cartDiscTotal.textContent = formatWon(discountTotal);

    const cartCpnDisc = $("#cartCouponDiscount");
    if (cartCpnDisc) cartCpnDisc.textContent = "-" + formatWon(cartCouponDiscountValue);

    const cartPntDisc = $("#cartPointDiscount");
    if (cartPntDisc) cartPntDisc.textContent = "-" + formatPoint(cartPointUseValue);

    const cartShipFee = $("#cartShippingFee");
    if (cartShipFee) cartShipFee.textContent = data.productTotal > 0 ? "무료" : "0원";

    const cartExpPnt = $("#cartExpectedPoint");
    if (cartExpPnt) cartExpPnt.textContent = formatPoint(expectedPoint);

    const cartGrndTotal = $("#cartGrandTotal");
    if (cartGrndTotal) cartGrndTotal.textContent = formatWon(grandTotal);

    const cartAll = $("#cartAll");
    const checks = $$(".cart-check");
    if (cartAll) {
      cartAll.checked = checks.length > 0 && checks.every(function (check) {
        return check.checked;
      });
      cartAll.indeterminate = checks.some(function (check) {
        return check.checked;
      }) && !cartAll.checked;
    }

    const checkoutButton = $("#cartCheckout");
    const benefitButton = $("#cartCouponOpen");
    if (checkoutButton) checkoutButton.disabled = data.itemCount === 0;
    if (benefitButton) benefitButton.disabled = data.itemCount === 0;

    updateCartBenefitPreview();
  }

  const cartAll = $("#cartAll");
  if (cartAll) {
    cartAll.addEventListener("change", function (event) {
      $$(".cart-check").forEach(function (check) {
        check.checked = event.target.checked;
      });
      updateCartTotals();
    });
  }

  const cartList = $("#cartList");
  if (cartList) {
    cartList.addEventListener("change", function (event) {
      if (event.target.matches(".cart-check")) updateCartTotals();
    });

    cartList.addEventListener("click", function (event) {
      const minusButton = event.target.closest(".cart-quantity-minus");
      const plusButton = event.target.closest(".cart-quantity-plus");
      const optionButton = event.target.closest(".cart-option-button");

      if (minusButton || plusButton) {
        const item = event.target.closest(".cart-item");
        const input = $(".cart-quantity-control input", item);
        let quantity = Number(input.value) || 1;
        quantity += plusButton ? 1 : -1;
        input.value = Math.max(1, Math.min(10, quantity));
        updateCartTotals();
        return;
      }

      if (optionButton) {
        cartOptionTarget = optionButton.closest(".cart-item");
        const sizeSelect = $("#cartOptionSize");
        const thumb = $(".shoe-thumb", cartOptionTarget);
        $("#cartOptionBrand").textContent = cartOptionTarget.dataset.brand || "";
        $("#cartOptionProductName").textContent = cartOptionTarget.dataset.productName || "";
        $("#cartOptionCurrent").textContent =
          (cartOptionTarget.dataset.color || "") + " · " +
          (cartOptionTarget.dataset.size || "") + "mm";
        $("#cartOptionThumb").textContent = thumb ? thumb.textContent : "";
        $("#cartOptionThumb").className = thumb ? thumb.className : "shoe-thumb";
        $("#cartOptionThumb").id = "cartOptionThumb";
        if (sizeSelect) {
          sizeSelect.value = cartOptionTarget.dataset.size || "255";
          if (window.jQuery && window.jQuery.fn && typeof window.jQuery.fn.niceSelect === "function") {
            window.jQuery(sizeSelect).niceSelect("update");
          }
        }
        openModal("cartOptionModal");
      }
    });
  }

  const cartOptionApply = $("#cartOptionApply");
  if (cartOptionApply) {
    cartOptionApply.addEventListener("click", function (event) {
      event.preventDefault();
      event.stopPropagation();
      if (!cartOptionTarget) return;
      const size = $("#cartOptionSize").value;
      cartOptionTarget.dataset.size = size;
      $(".cart-option-text", cartOptionTarget).textContent =
        (cartOptionTarget.dataset.color || "") + " · " + size + "mm";
      closeModal($("#cartOptionModal"));
      toast("상품 옵션을 " + size + "mm로 변경했어요.");
    });
  }

  const cartDeleteSelected = $("#cartDeleteSelected");
  if (cartDeleteSelected) {
    cartDeleteSelected.addEventListener("click", function () {
      const selected = $$(".cart-check:checked");
      if (!selected.length) return toast("삭제할 상품을 선택해 주세요.");
      if (!confirm(selected.length + "개 상품을 장바구니에서 삭제하시겠어요?")) return;
      selected.forEach(function (check) {
        check.closest(".cart-item").remove();
      });
      updateCartTotals();
      toast("선택한 상품을 삭제했어요.");
    });
  }

  const cartCouponOpen = $("#cartCouponOpen");
  if (cartCouponOpen) {
    cartCouponOpen.addEventListener("click", function (event) {
      event.preventDefault();
      event.stopPropagation();
      const data = getCartSelectedData();
      if (!data.itemCount) return toast("쿠폰을 적용할 상품을 선택해 주세요.");
      syncCartCouponDropdown(cartCouponCode);
      closeCartCouponDropdown();
      $("#cartPointInput").value = cartPointUseValue;
      setCartPointError("");
      updateCartBenefitPreview();
      openModal("cartBenefitModal");
    });
  }

  const cartCouponSelect = $("#cartCouponSelect");
  const cartCouponDropdown = $("#cartCouponDropdown");
  const cartCouponDropdownToggle = $("#cartCouponDropdownToggle");
  const cartCouponDropdownMenu = $("#cartCouponDropdownMenu");
  const cartCouponCurrentText = $("#cartCouponCurrentText");

  function closeCartCouponDropdown() {
    if (!cartCouponDropdown || !cartCouponDropdownToggle || !cartCouponDropdownMenu) return;
    cartCouponDropdown.classList.remove("is-open");
    cartCouponDropdownToggle.setAttribute("aria-expanded", "false");
    cartCouponDropdownMenu.hidden = true;
  }

  function openCartCouponDropdown() {
    if (!cartCouponDropdown || !cartCouponDropdownToggle || !cartCouponDropdownMenu) return;
    cartCouponDropdown.classList.add("is-open");
    cartCouponDropdownToggle.setAttribute("aria-expanded", "true");
    cartCouponDropdownMenu.hidden = false;
  }

  function syncCartCouponDropdown(code) {
    if (!cartCouponSelect) return;
    const nextCode = code || "none";
    cartCouponSelect.value = nextCode;

    const options = $$(".cart-coupon-option", cartCouponDropdown || document);
    let selectedText = "쿠폰을 적용하지 않음";

    options.forEach(function (option) {
      const selected = option.dataset.couponCode === nextCode;
      option.classList.toggle("is-selected", selected);
      option.setAttribute("aria-selected", selected ? "true" : "false");
      if (selected) {
        const title = $("strong", option);
        selectedText = title ? title.textContent.trim() : option.textContent.trim();
      }
    });

    if (cartCouponCurrentText) cartCouponCurrentText.textContent = selectedText;
  }

  if (cartCouponDropdownToggle) {
    cartCouponDropdownToggle.addEventListener("click", function (event) {
      event.preventDefault();
      event.stopPropagation();

      if (cartCouponDropdown && cartCouponDropdown.classList.contains("is-open")) {
        closeCartCouponDropdown();
      } else {
        openCartCouponDropdown();
      }
    });
  }

  $$(".cart-coupon-option").forEach(function (option) {
    option.addEventListener("click", function (event) {
      event.preventDefault();
      event.stopPropagation();

      syncCartCouponDropdown(option.dataset.couponCode || "none");
      closeCartCouponDropdown();
      setCartPointError("");
      normalizeCartPointInput(false);
      updateCartBenefitPreview();
      if (cartCouponDropdownToggle) cartCouponDropdownToggle.focus();
    });
  });

  document.addEventListener("click", function (event) {
    if (!cartCouponDropdown || cartCouponDropdown.contains(event.target)) return;
    closeCartCouponDropdown();
  });

  if (cartCouponDropdownToggle) {
    cartCouponDropdownToggle.addEventListener("keydown", function (event) {
      if (event.key === "ArrowDown" || event.key === "Enter" || event.key === " ") {
        event.preventDefault();
        openCartCouponDropdown();
        const selectedOption = $(".cart-coupon-option.is-selected", cartCouponDropdownMenu);
        if (selectedOption) selectedOption.focus();
      }
    });
  }

  $$(".cart-coupon-option").forEach(function (option, index, options) {
    option.addEventListener("keydown", function (event) {
      if (event.key === "Escape") {
        event.preventDefault();
        closeCartCouponDropdown();
        if (cartCouponDropdownToggle) cartCouponDropdownToggle.focus();
        return;
      }

      if (event.key !== "ArrowDown" && event.key !== "ArrowUp") return;
      event.preventDefault();
      const direction = event.key === "ArrowDown" ? 1 : -1;
      const nextIndex = (index + direction + options.length) % options.length;
      options[nextIndex].focus();
    });
  });

  syncCartCouponDropdown(cartCouponCode);

  const cartPointInput = $("#cartPointInput");
  if (cartPointInput) {
    cartPointInput.addEventListener("input", function () {
      setCartPointError("");
      normalizeCartPointInput(true);
      updateCartBenefitPreview();
    });

    cartPointInput.addEventListener("keydown", function (event) {
      if (event.key !== "ArrowUp") return;

      const data = getCartSelectedData();
      const couponCode = $("#cartCouponSelect").value;
      const couponDiscount = calculateCartCoupon(data.productTotal, couponCode);
      const pointLimit = getCartPointLimit(data.productTotal, couponDiscount);
      const currentPoint = Number(cartPointInput.value) || 0;

      if (currentPoint >= pointLimit) {
        event.preventDefault();
        cartPointInput.value = pointLimit;
        if (pointLimit === CART_MAX_USABLE_POINT) {
          setCartPointError(
            "보유 포인트가 부족합니다. 최대 " +
              formatPoint(CART_MAX_USABLE_POINT) +
              "까지 사용할 수 있어요."
          );
        } else {
          setCartPointError("결제 예정 금액보다 많은 포인트는 사용할 수 없어요.");
        }
        updateCartBenefitPreview();
      }
    });
  }

  const cartPointAll = $("#cartPointAll");
  if (cartPointAll) {
    cartPointAll.addEventListener("click", function (event) {
      event.preventDefault();
      event.stopPropagation();
      const data = getCartSelectedData();
      const couponCode = $("#cartCouponSelect").value;
      const couponDiscount = calculateCartCoupon(data.productTotal, couponCode);
      const usable = getCartPointLimit(data.productTotal, couponDiscount);
      $("#cartPointInput").value = usable;
      setCartPointError("");
      updateCartBenefitPreview();
    });
  }

  const cartBenefitApply = $("#cartBenefitApply");
  if (cartBenefitApply) {
    cartBenefitApply.addEventListener("click", function (event) {
      event.preventDefault();
      event.stopPropagation();
      const data = getCartSelectedData();
      const couponCode = $("#cartCouponSelect").value;
      const couponDiscount = calculateCartCoupon(data.productTotal, couponCode);
      const pointUse = Number($("#cartPointInput").value) || 0;
      const maximumPoint = getCartPointLimit(data.productTotal, couponDiscount);

      if (pointUse < 0) {
        setCartPointError("포인트는 0P 이상 입력해 주세요.");
        return;
      }
      if (pointUse > CART_MAX_USABLE_POINT) {
        $("#cartPointInput").value = CART_MAX_USABLE_POINT;
        setCartPointError(
          "보유 포인트가 부족합니다. 최대 " +
            formatPoint(CART_MAX_USABLE_POINT) +
            "까지 사용할 수 있어요."
        );
        updateCartBenefitPreview();
        return;
      }
      if (pointUse > maximumPoint) {
        $("#cartPointInput").value = maximumPoint;
        setCartPointError("결제 예정 금액보다 많은 포인트는 사용할 수 없어요.");
        updateCartBenefitPreview();
        return;
      }
      if (pointUse !== 0 && (pointUse < CART_POINT_UNIT || pointUse % CART_POINT_UNIT !== 0)) {
        setCartPointError("포인트는 1,000P 이상, 1,000P 단위로 사용해 주세요.");
        return;
      }

      setCartPointError("");
      cartCouponCode = couponCode;
      cartCouponDiscountValue = couponDiscount;
      cartPointUseValue = pointUse;
      closeModal($("#cartBenefitModal"));
      updateCartTotals();
      toast("쿠폰과 포인트가 적용되었습니다.");
    });
  }

  const cartContinueShopping = $("#cartContinueShopping");
  if (cartContinueShopping) {
    cartContinueShopping.addEventListener("click", function () {
      location.href = document.body.dataset.contextPath + "/product/category";
    });
  }

  const cartCheckout = $("#cartCheckout");
  if (cartCheckout) {
    cartCheckout.addEventListener("click", function () {
      const data = getCartSelectedData();
      if (!data.itemCount) return toast("주문할 상품을 선택해 주세요.");

      const finalTotal = Math.max(
        0,
        data.productTotal - cartCouponDiscountValue - cartPointUseValue
      );
      const orderItems = data.items.map(function (item) {
        return {
          productName: item.dataset.productName,
          brand: item.dataset.brand,
          color: item.dataset.color,
          size: item.dataset.size,
          quantity: Number($(".cart-quantity-control input", item).value) || 1,
          price: Number(item.dataset.price) || 0,
        };
      });

      sessionStorage.setItem(
        "yongsinsaCartOrder",
        JSON.stringify({
          items: orderItems,
          productTotal: data.productTotal,
          couponCode: cartCouponCode,
          couponDiscount: cartCouponDiscountValue,
          pointUse: cartPointUseValue,
          finalTotal: finalTotal,
        })
      );

      location.href = document.body.dataset.contextPath + "/order/agreement";
    });
  }

  updateCartTotals();

  const profileForm = $("#profileForm");
  const profileAddressStorageKey = "yongsinsa.profileAddress";

  if (profileForm) {
    try {
      const savedAddress = JSON.parse(
        localStorage.getItem(profileAddressStorageKey) || "null"
      );
      if (savedAddress) {
        const postcode = $("#profilePostcode");
        const address = $("#profileAddress");
        const detail = $("#profileAddressDetail");
        if (postcode) postcode.value = savedAddress.postcode || "";
        if (address) address.value = savedAddress.address || "";
        if (detail) detail.value = savedAddress.addressDetail || "";
      }
    } catch (error) {
      console.warn("저장된 주소 정보를 불러오지 못했습니다.", error);
    }
  }

  $$(".demo-form").forEach(function (form) {
    form.addEventListener("submit", function (event) {
      event.preventDefault();

      if (form.id === "profileForm") {
        const postcode = $("#profilePostcode");
        const address = $("#profileAddress");
        const detail = $("#profileAddressDetail");

        if (
          !postcode ||
          !postcode.value.trim() ||
          !address ||
          !address.value.trim()
        ) {
          toast("주소 검색을 통해 주소를 입력해 주세요.");
          return;
        }

        const addressDetail =
          detail && detail.value ? detail.value.trim() : "";

        try {
          localStorage.setItem(
            profileAddressStorageKey,
            JSON.stringify({
              postcode: postcode.value.trim(),
              address: address.value.trim(),
              addressDetail: addressDetail
            })
          );
        } catch (error) {
          console.warn(
            "주소 정보를 브라우저에 저장하지 못했습니다.",
            error
          );
        }
      }

      closeModal(form.closest(".modal"));
      toast("입력한 내용이 저장되었습니다.");
    });
  });

  document.addEventListener("keydown", function (event) {
    if (event.key === "Escape") {
      $$(".modal.is-open").forEach(function (modal) {
        closeModal(modal);
      });
    }
  });

  // 🔴 페이지 접속 시 현재 URL(location.pathname)을 확인해서 해당 탭 자동 출력
  activateHashView();
});