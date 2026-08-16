var contextPath = document.body.dataset.contextPath || "";
document.addEventListener("DOMContentLoaded", function () {
  var stickyTrade = document.querySelector(".sticky-trade");
  var hero = document.querySelector(".product-hero");
  var colorModal = document.getElementById("colorModal");
  var sizeModal = document.getElementById("sizeModal");
  var selectedOptionCard = document.getElementById("selectedOptionCard");
  var toast = document.getElementById("productToast");
  var selectedColor = "";
  var selectedSize = "";
  var toastTimer = null;
  var productSalePrice = 130000;
  var productFinalPrice = productSalePrice;
  var productCouponCode = "none";
  var productCouponDiscount = 0;
  var issuedProductCoupon = false;


  function showToast(message) {
    if (!toast) return;
    window.clearTimeout(toastTimer);
    toast.textContent = message;
    toast.classList.add("show");
    toastTimer = window.setTimeout(function () {
      toast.classList.remove("show");
    }, 2100);
  }

  function openModal(modal) {
    if (!modal) return;
    modal.classList.add("open");
    modal.setAttribute("aria-hidden", "false");
    document.body.classList.add("modal-open");
  }

  function closeModal(modal) {
    if (!modal) return;
    modal.classList.remove("open");
    modal.setAttribute("aria-hidden", "true");
    if (!document.querySelector(".modal-backdrop.open")) {
      document.body.classList.remove("modal-open");
    }
  }

  function setTextForAll(selector, value) {
    document.querySelectorAll(selector).forEach(function (item) {
      item.textContent = value;
    });
  }

  function formatProductWon(value) {
    return Number(value || 0).toLocaleString("ko-KR") + "원";
  }

  function calculateProductCoupon(code) {
    if (code === "rate10") return Math.min(Math.floor(productSalePrice * 0.1), 20000);
    if (code === "fixed15") return Math.min(15000, productSalePrice);
    if (code === "issued5") return Math.floor(productSalePrice * 0.05);
    return 0;
  }

  function getProductCouponLabel(code) {
    if (code === "rate10") return "10% 쿠폰 적용";
    if (code === "fixed15") return "15,000원 쿠폰 적용";
    if (code === "issued5") return "5% 상품 쿠폰 적용";
    return "쿠폰 적용";
  }

  function updateProductCouponPreview() {
    var select = document.getElementById("productCouponSelect");
    var code = select ? select.value : productCouponCode;
    var discount = calculateProductCoupon(code);
    var finalPrice = Math.max(0, productSalePrice - discount);
    var discountText = document.getElementById("productCouponPreviewDiscount");
    var priceText = document.getElementById("productCouponPreviewPrice");
    if (discountText) discountText.textContent = "-" + formatProductWon(discount);
    if (priceText) priceText.textContent = formatProductWon(finalPrice);
  }

  function updateAppliedProductPrice() {
    var line = document.getElementById("productCouponPriceLine");
    var price = document.getElementById("productCouponPrice");
    var rate = document.getElementById("productCouponRate");
    var openButton = document.getElementById("productCouponOpen");

    setTextForAll(".js-purchase-price", formatProductWon(productFinalPrice));

    if (productCouponCode === "none" || productCouponDiscount === 0) {
      if (line) line.hidden = true;
      if (openButton) openButton.textContent = "쿠폰 적용";
      return;
    }

    if (line) line.hidden = false;
    if (price) price.textContent = formatProductWon(productFinalPrice);
    if (rate) rate.textContent = getProductCouponLabel(productCouponCode);
    if (openButton) openButton.textContent = "쿠폰 변경";
  }

  function updateSelectedOption() {
    document.querySelectorAll(".js-open-color").forEach(function (button) {
      button.classList.toggle("selected", Boolean(selectedColor));
    });
    document.querySelectorAll(".js-open-size").forEach(function (button) {
      button.classList.toggle("selected", Boolean(selectedSize));
    });

    if (!selectedOptionCard) return;

    var name = selectedOptionCard.querySelector(".selected-option-name");
    var stock = selectedOptionCard.querySelector(".stock-badge");
    var complete = Boolean(selectedColor && selectedSize);

    selectedOptionCard.classList.toggle("complete", complete);

    if (complete) {
      name.textContent = selectedColor + " · " + selectedSize + "mm";
      stock.textContent = "재고 있음";
    } else if (selectedColor) {
      name.textContent = selectedColor + " · 사이즈를 선택해 주세요.";
      stock.textContent = "사이즈 선택 필요";
    } else if (selectedSize) {
      name.textContent = "색상을 선택해 주세요. · " + selectedSize + "mm";
      stock.textContent = "색상 선택 필요";
    } else {
      name.textContent = "옵션을 선택해 주세요.";
      stock.textContent = "옵션 선택 필요";
    }
  }

  if (stickyTrade && hero) {
    window.addEventListener("scroll", function () {
      stickyTrade.classList.toggle(
        "visible",
        window.scrollY > hero.offsetTop + 320
      );
    });
  }

  document.querySelectorAll(".js-open-color").forEach(function (button) {
    button.addEventListener("click", function () {
      openModal(colorModal);
    });
  });

  document.querySelectorAll(".js-open-size").forEach(function (button) {
    button.addEventListener("click", function () {
      openModal(sizeModal);
    });
  });

  var colorGrid = document.getElementById("colorGrid");
  if (colorGrid) {
    colorGrid.addEventListener("click", function (event) {
      var button = event.target.closest("button[data-color]");
      if (!button) return;

      colorGrid.querySelectorAll("button").forEach(function (item) {
        item.classList.remove("active");
      });
      button.classList.add("active");

      selectedColor = button.dataset.color;
      setTextForAll(".selected-color", selectedColor);
      updateSelectedOption();
      closeModal(colorModal);
      showToast(selectedColor + " 색상을 선택했습니다.");
    });
  }

  var sizeGrid = document.getElementById("sizeGrid");
  if (sizeGrid) {
    sizeGrid.addEventListener("click", function (event) {
      var button = event.target.closest("button[data-size]");
      if (!button || button.disabled) return;

      sizeGrid.querySelectorAll("button").forEach(function (item) {
        item.classList.remove("active");
      });
      button.classList.add("active");

      selectedSize = button.dataset.size;
      setTextForAll(".selected-size", selectedSize + "mm");
      updateSelectedOption();
      closeModal(sizeModal);
      showToast(selectedSize + "mm 사이즈를 선택했습니다.");
    });
  }

  document.querySelectorAll(".js-purchase").forEach(function (button) {
    button.addEventListener("click", function () {
      if (!selectedColor) {
        showToast("색상을 먼저 선택해 주세요.");
        openModal(colorModal);
        return;
      }
      if (!selectedSize) {
        showToast("사이즈를 선택해 주세요.");
        openModal(sizeModal);
        return;
      }

      sessionStorage.setItem(
        "yongsinsaTrade",
        JSON.stringify({
          productName: "아디다스 ZX 8000 그레이 투 퍼플",
          color: selectedColor,
          size: selectedSize,
          price: formatProductWon(productFinalPrice),
          originalPrice: formatProductWon(productSalePrice),
          couponCode: productCouponCode,
          couponDiscount: productCouponDiscount,
          quantity: 1,
          trade: "buy"
        })
      );

      // TODO: 백엔드 연결 후 구매 Controller 주소로 변경하세요.
      // UI 확인용 ?preview=member 값이 있으면 다음 결제 화면에도 유지합니다.
      var previewMember = new URLSearchParams(location.search).get("preview") === "member";
      location.href =
        contextPath + "/order/agreement" + (previewMember ? "?preview=member" : "");
    });
  });

  var interestActive = false;
  document.querySelectorAll(".js-interest").forEach(function (button) {
    button.addEventListener("click", function () {
      interestActive = !interestActive;
      document.querySelectorAll(".js-interest").forEach(function (item) {
        item.classList.toggle("active", interestActive);
        item.setAttribute("aria-pressed", String(interestActive));
      });
      document.querySelectorAll(".bookmark-button").forEach(function (item) {
        item.textContent = interestActive ? "♥" : "♡";
      });
      document.querySelectorAll(".interest-icon").forEach(function (item) {
        item.textContent = interestActive ? "♥" : "♡";
      });
      setTextForAll(".interest-count", interestActive ? "1,285" : "1,284");
      showToast(
        interestActive
          ? "관심상품에 추가했습니다."
          : "관심상품에서 해제했습니다."
      );
    });
  });

  var restockButton = document.querySelector(".js-restock");
  if (restockButton) {
    restockButton.addEventListener("click", function () {
      var active = restockButton.classList.toggle("active");
      restockButton.setAttribute("aria-pressed", String(active));
      var icon = restockButton.querySelector(".restock-icon");
      var label = restockButton.querySelector(".restock-label");
      if (icon) icon.textContent = active ? "◆" : "♢";
      if (label) label.textContent = active ? "재입고 알림 해제" : "재입고 알림 신청";
      showToast(active ? "재입고 알림을 신청했습니다." : "재입고 알림을 해제했습니다.");
    });
  }

  var shareButton = document.querySelector(".share-button");
  if (shareButton) {
    shareButton.addEventListener("click", function () {
      if (navigator.share) {
        navigator.share({ title: document.title, url: location.href });
      } else if (navigator.clipboard) {
        navigator.clipboard.writeText(location.href).then(function () {
          showToast("상품 주소를 복사했습니다.");
        });
      } else {
        showToast("주소창의 상품 주소를 복사해 주세요.");
      }
    });
  }

  var productCouponModal = document.getElementById("productCouponModal");
  var productCouponOpen = document.getElementById("productCouponOpen");
  var productCouponSelect = document.getElementById("productCouponSelect");
  var productCouponIssue = document.getElementById("productCouponIssue");
  var productCouponApply = document.getElementById("productCouponApply");

  if (productCouponOpen) {
    productCouponOpen.addEventListener("click", function () {
      if (productCouponSelect) productCouponSelect.value = productCouponCode;
      if (window.jQuery && window.jQuery.fn && typeof window.jQuery.fn.niceSelect === "function" && productCouponSelect) {
        window.jQuery(productCouponSelect).niceSelect("update");
      }
      updateProductCouponPreview();
      openModal(productCouponModal);
    });
  }

  if (productCouponSelect) {
    productCouponSelect.addEventListener("change", updateProductCouponPreview);
  }

  if (productCouponIssue) {
    productCouponIssue.addEventListener("click", function () {
      if (issuedProductCoupon) return;
      issuedProductCoupon = true;
      var option = document.getElementById("issuedProductCouponOption");
      if (option) {
        option.hidden = false;
        option.disabled = false;
      }
      productCouponSelect.value = "issued5";
      productCouponIssue.disabled = true;
      productCouponIssue.textContent = "발급 완료";
      if (window.jQuery && window.jQuery.fn && typeof window.jQuery.fn.niceSelect === "function") {
        window.jQuery(productCouponSelect).niceSelect("update");
      }
      updateProductCouponPreview();
      showToast("상품 전용 5% 쿠폰을 발급받았습니다.");
    });
  }

  if (productCouponApply) {
    productCouponApply.addEventListener("click", function () {
      productCouponCode = productCouponSelect ? productCouponSelect.value : "none";
      productCouponDiscount = calculateProductCoupon(productCouponCode);
      productFinalPrice = Math.max(0, productSalePrice - productCouponDiscount);
      updateAppliedProductPrice();
      closeModal(productCouponModal);
      showToast(
        productCouponCode === "none"
          ? "쿠폰 적용을 해제했습니다."
          : "쿠폰이 적용되었습니다."
      );
    });
  }

  updateAppliedProductPrice();

  document.querySelectorAll(".modal-backdrop").forEach(function (modal) {
    var closeButton = modal.querySelector(".modal-close");
    if (closeButton) {
      closeButton.addEventListener("click", function () {
        closeModal(modal);
      });
    }
    modal.addEventListener("click", function (event) {
      if (event.target === modal) closeModal(modal);
    });
  });

  document.addEventListener("keydown", function (event) {
    if (event.key === "Escape") {
      document.querySelectorAll(".modal-backdrop.open").forEach(function (modal) {
        closeModal(modal);
      });
      closeOwnerMenus();
    }
  });

  document.querySelectorAll(".detail-tabs button").forEach(function (button) {
    button.addEventListener("click", function () {
      document.querySelectorAll(".detail-tabs button").forEach(function (item) {
        item.classList.remove("active");
      });
      document.querySelectorAll(".tab-panel").forEach(function (panel) {
        panel.classList.remove("active");
      });
      button.classList.add("active");
      var panel = document.getElementById(button.dataset.tab);
      if (panel) panel.classList.add("active");
    });
  });

  var reviewWriteButton = document.getElementById("reviewWriteButton");
  if (reviewWriteButton) {
    reviewWriteButton.addEventListener("click", function () {
      alert("리뷰 등록 화면은 구매 완료 여부 확인 기능과 연결한 뒤 사용할 수 있습니다.");
    });
  }

  function closeOwnerMenus(except) {
    document.querySelectorAll(".owner-actions.open").forEach(function (actions) {
      if (actions === except) return;
      actions.classList.remove("open");
      var menuButton = actions.querySelector(".owner-menu-button");
      if (menuButton) menuButton.setAttribute("aria-expanded", "false");
    });
  }

  document.querySelectorAll(".owner-menu-button").forEach(function (button) {
    button.addEventListener("click", function (event) {
      event.stopPropagation();
      var actions = button.closest(".owner-actions");
      if (!actions) return;
      var willOpen = !actions.classList.contains("open");
      closeOwnerMenus(actions);
      actions.classList.toggle("open", willOpen);
      button.setAttribute("aria-expanded", String(willOpen));
    });
  });

  document.querySelectorAll(".owner-edit").forEach(function (button) {
    button.addEventListener("click", function () {
      var post = button.closest(".owner-post");
      var content = post ? post.querySelector(".editable-content") : null;
      if (!content) return;

      var postType = post.classList.contains("review-card") ? "리뷰" : "문의";
      var changedText = window.prompt(postType + " 내용을 수정해 주세요.", content.textContent.trim());
      closeOwnerMenus();
      if (changedText === null) return;
      changedText = changedText.trim();
      if (!changedText) {
        showToast("내용을 입력해 주세요.");
        return;
      }
      content.textContent = changedText;
      showToast(postType + "를 수정했습니다.");
    });
  });

  document.querySelectorAll(".owner-delete").forEach(function (button) {
    button.addEventListener("click", function () {
      var post = button.closest(".owner-post");
      if (!post) return;
      var postType = post.classList.contains("review-card") ? "리뷰" : "문의";
      if (!window.confirm("작성한 " + postType + "를 삭제하시겠습니까?")) return;
      post.remove();
      closeOwnerMenus();
      showToast(postType + "를 삭제했습니다.");
    });
  });

  document.addEventListener("click", function (event) {
    if (!event.target.closest(".owner-actions")) closeOwnerMenus();
  });

  var questionButton = document.getElementById("questionButton");
  if (questionButton) {
    questionButton.addEventListener("click", function () {
      alert("문의 등록 화면은 로그인 기능과 연결한 뒤 사용할 수 있습니다.");
    });
  }

  document.querySelectorAll(".js-more-toggle").forEach(function (button) {
    button.addEventListener("click", function () {
      // 버튼의 data-target 속성에 적힌 아이디(infoContent 또는 recommendGrid)를 가져옵니다.
      var targetId = button.dataset.target;
      var targetElement = document.getElementById(targetId);

      if (!targetElement) return;

      // 해당 요소의 collapsed 클래스를 껐다 켭니다.
      targetElement.classList.toggle("collapsed");
      
      // 클래스 유무에 따라 버튼 글자를 바꿔줍니다.
      button.textContent = targetElement.classList.contains("collapsed") ? "더보기" : "접기";
    });
  });

  function renderSalesChart(button) {
    var chart = document.getElementById("salesChart");
    if (!button || !chart) return;
    var period = button.dataset.period;
    setTextForAll(".sales-period-label", button.dataset.label || "");
    setTextForAll(".sales-total", button.dataset.total || "0");
    setTextForAll(".sales-change", button.dataset.change || "");
    var visibleCount = 0;
    chart.querySelectorAll("[data-sales-period]").forEach(function (item) {
      var show = item.dataset.salesPeriod === period;
      item.hidden = !show;
      if (show) visibleCount += 1;
    });
    chart.style.gridTemplateColumns = "repeat(" + visibleCount + ", 1fr)";
  }

  document.querySelectorAll(".period-tabs button").forEach(function (button) {
    button.addEventListener("click", function () {
      button.parentElement.querySelectorAll("button").forEach(function (item) {
        item.classList.remove("active");
      });
      button.classList.add("active");
      renderSalesChart(button);
    });
  });

  updateSelectedOption();
});
