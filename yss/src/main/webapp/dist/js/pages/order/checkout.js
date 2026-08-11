// 구매 약관, 회원/비회원 결제, 주문 금액, 완료 화면을 연결하는 공통 스크립트
(function () {
  "use strict";

  var contextPath = window.paymentContextPath || "";
  var body = document.body;
  var loggedIn = body && body.getAttribute("data-logged-in") === "true";
  var previewMember = body && body.getAttribute("data-preview-member") === "true";

  function won(value) {
    return Number(value || 0).toLocaleString("ko-KR") + "원";
  }

  function onlyNumber(value) {
    return Number(String(value || "").replace(/[^0-9]/g, "")) || 0;
  }

  function getTrade() {
    var fallback = {
      productName: "아디다스 ZX 8000 그레이 투 퍼플",
      color: "그레이 투 퍼플",
      size: "260",
      price: "130,000원",
      quantity: 1,
      trade: "buy",
    };

    try {
      var saved = sessionStorage.getItem("yongsinsaTrade");
      var parsed = saved ? JSON.parse(saved) : null;
      if (!parsed || parsed.trade !== "buy") return fallback;
      return {
        productName: parsed.productName || fallback.productName,
        color: parsed.color || fallback.color,
        size: parsed.size || fallback.size,
        price: parsed.price || fallback.price,
        quantity: Number(parsed.quantity) || 1,
        trade: "buy",
      };
    } catch (error) {
      return fallback;
    }
  }

  var trade = getTrade();
  var productPrice = onlyNumber(trade.price) || 130000;
  var shippingFee = 0;
  var couponDiscount = 0;

  function optionText() {
    return trade.color + " · " + trade.size + "mm · " + trade.quantity + "개";
  }

  function setText(selector, value) {
    var element = document.querySelector(selector);
    if (element) element.textContent = value;
  }

  function fillProductSummary() {
    setText("#agreementProductName", trade.productName);
    setText("#agreementColor", trade.color);
    setText("#agreementSize", trade.size + "mm");
    setText("#agreementProductPrice", won(productPrice));
    setText("#agreementTotal", won(productPrice + shippingFee));

    setText("#checkoutProductName", trade.productName);
    setText("#checkoutProductOption", optionText());
    setText("#checkoutProductPrice", won(productPrice));

    setText("#completeProductName", trade.productName);
    setText("#completeProductOption", optionText());
    setText("#completeProductPrice", won(productPrice));
  }

  fillProductSummary();

  // 구매 약관 전체 선택 및 필수 약관 검사
  var agreeAll = document.querySelector("#agreeAll");
  var agreementItems = document.querySelectorAll(
    ".required-agree, .optional-agree"
  );
  var requiredAgreements = document.querySelectorAll(".required-agree");
  var agreementNext = document.querySelector("#agreementNext");

  function allRequiredChecked() {
    if (!requiredAgreements.length) return false;
    for (var i = 0; i < requiredAgreements.length; i++) {
      if (!requiredAgreements[i].checked) return false;
    }
    return true;
  }

  function refreshAgreement() {
    if (!agreeAll) return;
    var checked = agreementItems.length > 0;
    for (var i = 0; i < agreementItems.length; i++) {
      if (!agreementItems[i].checked) checked = false;
    }
    agreeAll.checked = checked;
  }

  if (agreeAll) {
    agreeAll.addEventListener("change", function () {
      for (var i = 0; i < agreementItems.length; i++) {
        agreementItems[i].checked = agreeAll.checked;
      }
    });
  }

  for (var agreementIndex = 0; agreementIndex < agreementItems.length; agreementIndex++) {
    agreementItems[agreementIndex].addEventListener("change", refreshAgreement);
  }

  if (agreementNext) {
    agreementNext.addEventListener("click", function () {
      var message = document.querySelector("#agreementMessage");
      if (!allRequiredChecked()) {
        if (message) message.textContent = "필수 동의 항목을 모두 확인해 주세요.";
        for (var i = 0; i < requiredAgreements.length; i++) {
          if (!requiredAgreements[i].checked) {
            requiredAgreements[i].focus();
            break;
          }
        }
        return;
      }

      if (message) message.textContent = "";
      // TODO: 백엔드 연결 후 결제 Controller 주소로 변경하세요.
      location.href =
        contextPath + "/order/checkout" + (previewMember ? "?preview=member" : "");
    });
  }

  // 로그인 상태에 따라 회원 자동입력 영역과 비회원 주문 비밀번호 영역을 구분한다.
  var orderType = document.querySelector("[name=orderType]");
  var guestFields = document.querySelectorAll(".guest-only");
  var orderTypeGuide = document.querySelector("#orderTypeGuide");
  var orderTypeBadge = document.querySelector("#orderTypeBadge");

  function setOrderType() {
    if (orderType) orderType.value = loggedIn ? "member" : "guest";

    for (var i = 0; i < guestFields.length; i++) {
      var input = guestFields[i].querySelector("input");
      guestFields[i].style.display = loggedIn ? "none" : "flex";
      if (input) input.required = !loggedIn;
    }

    if (orderTypeBadge) {
      orderTypeBadge.textContent = loggedIn ? "회원 구매" : "비회원 구매";
    }

    if (orderTypeGuide) {
      orderTypeGuide.textContent = loggedIn
        ? "주문자 정보가 자동으로 입력되었습니다. 배송지는 직접 입력하거나 기본배송지를 불러올 수 있습니다."
        : "주문 조회에 사용할 주문 비밀번호와 주문자 정보를 직접 입력해 주세요.";
    }
  }

  setOrderType();

  // 회원이 '기본배송지'를 눌렀을 때 마이페이지에 저장된 주소를 입력한다.
  var useDefaultAddress = document.querySelector("#useDefaultAddress");
  var defaultAddressMessage = document.querySelector("#defaultAddressMessage");

  function setInputValue(name, value) {
    var input = document.querySelector("[name=" + name + "]");
    if (input) input.value = value || "";
  }

  if (useDefaultAddress) {
    useDefaultAddress.addEventListener("click", function () {
      var postcode = this.getAttribute("data-postcode") || "";
      var address = this.getAttribute("data-address") || "";
      var addressDetail = this.getAttribute("data-address-detail") || "";

      if (!postcode || !address) {
        if (defaultAddressMessage) {
          defaultAddressMessage.textContent =
            "저장된 기본배송지가 없습니다. 마이페이지에서 주소를 등록해 주세요.";
          defaultAddressMessage.classList.add("is-error");
        }
        return;
      }

      setInputValue("receiverName", this.getAttribute("data-name"));
      setInputValue("receiverPhone", this.getAttribute("data-phone"));
      setInputValue("postcode", postcode);
      setInputValue("address", address);
      setInputValue("addressDetail", addressDetail);

      if (defaultAddressMessage) {
        defaultAddressMessage.textContent = "기본배송지를 불러왔습니다.";
        defaultAddressMessage.classList.remove("is-error");
      }

      var detailInput = document.querySelector("[name=addressDetail]");
      if (detailInput) detailInput.focus();
    });
  }

  // 카드번호와 날짜 입력 형식
  var cardNumberInput = document.querySelector("[name=cardNumber]");
  var cardExpiryInput = document.querySelector("[name=cardExpiry]");
  var cardBirthInput = document.querySelector("[name=cardBirth]");

  if (cardNumberInput) {
    cardNumberInput.addEventListener("input", function () {
      var digits = this.value.replace(/[^0-9]/g, "").slice(0, 16);
      var groups = digits.match(/.{1,4}/g);
      this.value = groups ? groups.join(" - ") : "";
    });
  }

  if (cardExpiryInput) {
    cardExpiryInput.addEventListener("input", function () {
      var digits = this.value.replace(/[^0-9]/g, "").slice(0, 4);
      this.value =
        digits.length > 2
          ? digits.slice(0, 2) + " / " + digits.slice(2)
          : digits;
    });
  }

  if (cardBirthInput) {
    cardBirthInput.addEventListener("input", function () {
      this.value = this.value.replace(/[^0-9]/g, "").slice(0, 6);
    });
  }

  // 카카오(다음) 우편번호 주소 검색
  var postcodeButton = document.querySelector("#postcodeButton");
  if (postcodeButton) {
    postcodeButton.addEventListener("click", function () {
      if (typeof daum === "undefined" || !daum.Postcode) {
        alert("주소 검색 서비스를 불러오지 못했습니다. 인터넷 연결을 확인해 주세요.");
        return;
      }

      new daum.Postcode({
        oncomplete: function (data) {
          setInputValue("postcode", data.zonecode);
          setInputValue("address", data.roadAddress || data.jibunAddress);
          var detail = document.querySelector("[name=addressDetail]");
          if (detail) detail.focus();
        },
      }).open();
    });
  }

  // 포인트 및 쿠폰 금액 계산
  var pointInput = document.querySelector("#pointInput");
  var couponInput = document.querySelector("#couponInput");
  var guestCouponInput = document.querySelector("#guestCouponInput");

  function normalizePoint() {
    if (!loggedIn || !pointInput) return 0;
    var value = Number(pointInput.value) || 0;
    value = Math.min(12400, Math.max(0, Math.floor(value / 100) * 100));
    pointInput.value = value;
    return value;
  }

  function currentDiscount() {
    return normalizePoint() + couponDiscount;
  }

  function updatePrice() {
    var discount = Math.min(productPrice + shippingFee, currentDiscount());
    var total = Math.max(0, productPrice + shippingFee - discount);

    setText("#shippingAmount", shippingFee === 0 ? "무료" : won(shippingFee));
    setText("#discountAmount", "- " + won(discount));
    setText("#finalPrice", won(total));
    setText("#payButtonPrice", won(total));
    setText("#expectedPoint", Math.floor(productPrice * 0.01).toLocaleString("ko-KR") + "P");

    return total;
  }

  function applyCoupon(input, messageSelector) {
    var message = document.querySelector(messageSelector);
    var code = input ? input.value.trim().toUpperCase() : "";
    couponDiscount = code === "WELCOME10" ? 10000 : 0;

    if (message) {
      message.textContent = couponDiscount
        ? "WELCOME10 쿠폰 10,000원이 적용되었습니다."
        : "사용 가능한 예시 쿠폰은 WELCOME10입니다.";
      message.style.color = couponDiscount ? "#3158df" : "#e64242";
    }
    updatePrice();
  }

  var maxPointButton = document.querySelector("#maxPoint");
  if (maxPointButton && pointInput) {
    maxPointButton.addEventListener("click", function () {
      pointInput.value = 12400;
      updatePrice();
    });
    pointInput.addEventListener("change", updatePrice);
  }

  var applyCouponButton = document.querySelector("#applyCoupon");
  if (applyCouponButton) {
    applyCouponButton.addEventListener("click", function () {
      applyCoupon(couponInput, "#discountMessage");
    });
  }

  var guestApplyCouponButton = document.querySelector("#guestApplyCoupon");
  if (guestApplyCouponButton) {
    guestApplyCouponButton.addEventListener("click", function () {
      applyCoupon(guestCouponInput, "#guestDiscountMessage");
    });
  }

  // 선택한 결제수단에 필요한 입력 영역만 표시한다.
  var paymentMethods = document.querySelectorAll("[name=paymentMethod]");
  var cardFields = document.querySelector("#cardFields");
  var bankFields = document.querySelector("#bankFields");
  var easyPayFields = document.querySelector("#easyPayFields");

  function selectedPaymentValue() {
    var selected = document.querySelector("[name=paymentMethod]:checked");
    return selected ? selected.value : "";
  }

  function changePaymentMethod() {
    var method = selectedPaymentValue();

    if (cardFields) {
      cardFields.style.display = method === "신용카드" ? "grid" : "none";
      var cardInputs = cardFields.querySelectorAll("input");
      for (var i = 0; i < cardInputs.length; i++) {
        cardInputs[i].required = method === "신용카드";
      }
    }

    if (bankFields) bankFields.hidden = method !== "무통장입금";
    if (easyPayFields) easyPayFields.hidden = method !== "간편결제";
  }

  for (var methodIndex = 0; methodIndex < paymentMethods.length; methodIndex++) {
    paymentMethods[methodIndex].addEventListener("change", changePaymentMethod);
  }
  changePaymentMethod();

  // 주문서 검사 후 완료 페이지로 전달한다.
  var checkoutForm = document.querySelector("#checkoutForm");
  if (checkoutForm) {
    checkoutForm.addEventListener("submit", function (event) {
      event.preventDefault();

      var message = document.querySelector("#checkoutMessage");
      var postcode = document.querySelector("[name=postcode]");
      var basicAddress = document.querySelector("[name=address]");

      if (!postcode || !basicAddress || !postcode.value || !basicAddress.value) {
        if (message) message.textContent = "주소 찾기를 눌러 배송지 주소를 입력해 주세요.";
        if (postcodeButton) postcodeButton.focus();
        return;
      }

      var password = document.querySelector("[name=orderPassword]");
      var passwordConfirm = document.querySelector("[name=orderPasswordConfirm]");
      if (
        password &&
        password.required &&
        passwordConfirm &&
        password.value !== passwordConfirm.value
      ) {
        passwordConfirm.setCustomValidity("주문 비밀번호가 일치하지 않습니다.");
      } else if (passwordConfirm) {
        passwordConfirm.setCustomValidity("");
      }

      if (!checkoutForm.checkValidity()) {
        if (message) message.textContent = "빨간 별표(*)가 있는 필수 항목을 모두 작성해 주세요.";
        var invalid = checkoutForm.querySelector(":invalid");
        if (invalid) {
          invalid.focus();
          invalid.reportValidity();
        }
        return;
      }

      var paymentValue = selectedPaymentValue();
      if (
        paymentValue === "무통장입금" &&
        !document.querySelector("[name=depositBank]:checked")
      ) {
        if (message) message.textContent = "입금할 은행을 하나 선택해 주세요.";
        var firstBank = document.querySelector("[name=depositBank]");
        if (firstBank) firstBank.focus();
        return;
      }

      if (paymentValue === "간편결제" && !loggedIn) {
        if (message) message.textContent = "간편결제는 로그인한 회원만 사용할 수 있습니다.";
        if (easyPayFields) {
          easyPayFields.scrollIntoView({ behavior: "smooth", block: "center" });
        }
        return;
      }

      if (
        paymentValue === "간편결제" &&
        loggedIn &&
        !document.querySelector("[name=savedCard]:checked")
      ) {
        if (message) message.textContent = "결제에 사용할 등록 카드를 선택해 주세요.";
        var firstSavedCard = document.querySelector("[name=savedCard]");
        if (firstSavedCard) firstSavedCard.focus();
        return;
      }

      var methodText = paymentValue;
      var bank = document.querySelector("[name=depositBank]:checked");
      var savedCard = document.querySelector("[name=savedCard]:checked");
      if (bank) methodText += " · " + bank.value;
      if (savedCard && paymentValue === "간편결제") {
        methodText += " · " + savedCard.value;
      }

      var addressDetail = document.querySelector("[name=addressDetail]");
      var receiverName = document.querySelector("[name=receiverName]");
      var receiverPhone = document.querySelector("[name=receiverPhone]");
      var address = basicAddress.value + " " + (addressDetail ? addressDetail.value : "");
      var now = new Date();
      var datePart =
        String(now.getFullYear()).slice(-2) +
        String(now.getMonth() + 1).padStart(2, "0") +
        String(now.getDate()).padStart(2, "0");
      var randomPart = String(Math.floor(Math.random() * 900000) + 100000);

      var orderData = {
        price: won(updatePrice()),
        productPrice: won(productPrice),
        method: methodText,
        address: address.trim(),
        receiver: receiverName ? receiverName.value : "",
        receiverPhone: receiverPhone ? receiverPhone.value : "",
        order: "YS" + datePart + "-" + randomPart,
        orderType: loggedIn ? "member" : "guest",
        productName: trade.productName,
        color: trade.color,
        size: trade.size,
        quantity: trade.quantity,
      };

      sessionStorage.setItem("estoreOrder", JSON.stringify(orderData));
      // TODO: 실제 결제 승인 후 완료 Controller 주소로 변경하세요.
      location.href = contextPath + "/order/complete";
    });
  }

  // 결제 완료 페이지는 회원·비회원 공통 구조를 사용하고 안내만 구분한다.
  var completePrice = document.querySelector("#completePrice");
  if (completePrice) {
    try {
      var savedOrder = sessionStorage.getItem("estoreOrder");
      var data = savedOrder ? JSON.parse(savedOrder) : null;

      if (data) {
        setText("#completePrice", data.price || won(productPrice));
        setText("#completeProductPrice", data.productPrice || won(productPrice));
        setText("#completeMethod", data.method || "신용카드");
        setText("#completeAddress", data.address || "입력한 배송지");
        setText("#completeReceiver", data.receiver || "주문자");
        setText("#orderNumber", data.order || "A0000001");
        setText("#completeProductName", data.productName || trade.productName);
        setText(
          "#completeProductOption",
          (data.color || trade.color) +
            " · " +
            (data.size || trade.size) +
            "mm · " +
            (data.quantity || trade.quantity) +
            "개"
        );

        var guestNotice = document.querySelector("#guestOrderNotice");
        var completeGuide = document.querySelector("#completeGuide");
        var orderHistoryLink = document.querySelector("#orderHistoryLink");
        var isGuestOrder = data.orderType === "guest";

        if (guestNotice) guestNotice.hidden = !isGuestOrder;
        if (completeGuide) {
          completeGuide.textContent = isGuestOrder
            ? "주문번호를 보관해 주세요. 비회원 주문조회에 사용됩니다."
            : "주문 내역과 배송 진행 상황은 마이페이지에서 확인할 수 있습니다.";
        }
        if (orderHistoryLink) {
          orderHistoryLink.textContent = isGuestOrder ? "비회원 주문 조회" : "주문 내역 보기";
          orderHistoryLink.href = isGuestOrder
            ? contextPath + "/member/login#guest-order"
            : contextPath + "/mypage";
        }
      }
    } catch (error) {
      // 저장 정보가 없으면 화면의 기본 예시 값을 유지합니다.
    }
  }

  var copyOrderNumber = document.querySelector("#copyOrderNumber");
  if (copyOrderNumber) {
    copyOrderNumber.addEventListener("click", function () {
      var orderNumber = document.querySelector("#orderNumber");
      var value = orderNumber ? orderNumber.textContent.trim() : "";
      if (!value) return;

      if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(value).then(function () {
          copyOrderNumber.textContent = "복사됨";
        });
      } else {
        var temp = document.createElement("textarea");
        temp.value = value;
        document.body.appendChild(temp);
        temp.select();
        document.execCommand("copy");
        temp.remove();
        copyOrderNumber.textContent = "복사됨";
      }
    });
  }

  updatePrice();
  refreshAgreement();
})();
