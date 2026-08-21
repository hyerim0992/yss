var contextPath = document.body.dataset.contextPath || "";
document.addEventListener("DOMContentLoaded", function () {
  var stickyTrade = document.querySelector(".sticky-trade");
  var hero = document.querySelector(".product-hero");
  var colorModal = document.getElementById("colorModal");
  var sizeModal = document.getElementById("sizeModal");
  var reviewModal = document.getElementById("reviewModal");
  var QnAModal = document.getElementById("QnAModal");
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
  
  function closeModal(modal) {
    if (!modal) return;
    modal.classList.remove("open");
    modal.setAttribute("aria-hidden", "true");
    if (!document.querySelector(".reviewmodal-backdrop.open")) {
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
	var quantity = selectedOptionCard.querySelector(".quantity");
    var complete = Boolean(selectedColor && selectedSize);
	

    selectedOptionCard.classList.toggle("complete", complete);

    if (complete) {
      name.textContent = selectedColor + " · " + selectedSize + "mm";
	  quantity.classList.toggle("quantity-input");
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
      showToast('색상을 먼저 선택해주세요.');
	  openModal(colorModal);
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
	  
	  var prodId = event.target.closest("button[data-prod-id]").dataset.prodId;
	  
  	  const url = "detail/size";
  	  const params = {color: selectedColor, prodId: prodId};
	  
	  console.log(params);
	  
  	  const fn = function(data){
		const sizeModalContainer = document.getElementById("sizeGrid");
		sizeModalContainer.innerHTML = "";
		
		if( ! data|| data.length === 0){
			sizeModalContainer.innerHTML = "<p>선택 가능한 사이즈가 없습니다.</p>";
		}else{
			
			let htmlString = "";
			
			console.log(data);
			
			for (let el of data.OptionList)
			htmlString += `			
				<button type="button" data-size="${el.prodSize}" data-price="${el.price}" data-addprice="${el.addPrice}" 
				${el.changedStock == 0 ? "disabled" : ""}>
					${el.prodSize}<small>${el.changedStock == 0 ? "품절" : el.changedStock+"개"}</small>
					${el.addPrice !== 0 ? `<small>+${el.addPrice}원</small>` : ''}
				</button>
			`;
			
			sizeModalContainer.innerHTML = htmlString;
		}
		
  		openModal(sizeModal);
  	  }
  	
  	  ajaxRequest(url, 'get', params, 'json', fn);
  
  
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
	  price = button.dataset.price;
	  addPrice = button.dataset.addprice;
      setTextForAll(".selected-size", selectedSize + "mm");
      updateSelectedOption();
      closeModal(sizeModal);
      showToast(selectedSize + "mm 사이즈를 선택했습니다.");
	  addSelectedOption(selectedColor, selectedSize, price, addPrice);
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
		const wishlist = document.querySelector(".js-interest").dataset.wishlist;
		console.log(wishlist);
		interestActive = !interestActive;
		const url = "detail/wishlist";
		const params = {prodId: prodId , interestActive: interestActive};
		console.log(params);

		const fn = function(data){
			
			console.log(data);
			if (data.return === "null"){
				if(! confirm("로그인이 필요한 서비스입니다. 로그인하시겠습니까?")){
					return;
				}
				location.href = contextPath + "/member/login";
				
			}else{
				interestActive= JSON.parse(data.return);
			}
			
			document.querySelectorAll(".js-interest").forEach(function (item) {
			  item.classList.toggle("active", interestActive);
			  item.setAttribute("aria-pressed", String(interestActive));
			});
			document.querySelectorAll(".wishlist-button").forEach(function (item) {
			  item.textContent = interestActive ? "♥" : "♡";
			});
			setTextForAll(".interest-count", interestActive ? Number(wishlist)+1 : wishlist);
			showToast(
			  interestActive
			    ? "관심상품에 추가했습니다."
			    : "관심상품에서 해제했습니다."
			);
		  }

		  ajaxRequest(url, 'post', params, 'json', fn);
				
		

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

  // 기본 데이터 정의 (실제 환경에서는 서버/모달에서 선택된 값이 들어옵니다)
  const UNIT_PRICE = 130000; // 상품 단가
  const selectedOptions = new Map(); // 중복 선택 방지 및 상태 관리용 Map

  const optionListContainer = document.getElementById('selectedOptionList');
  const totalPriceEl = document.getElementById('totalPrice');
  const cartBtn = document.querySelector('.js-cart-btn');
  const buyBtn = document.querySelector('.js-buy-btn');

  /**
   * 1. 외부 모달/클릭 이벤트에서 옵션 선택이 완료되었을 때 호출하는 함수
   * @param {string} color - 선택된 색상
   * @param {string} size - 선택된 사이즈
   */
  function addSelectedOption(color, size, price, addPrice) {
      const optionKey = `${color}/${size}`;

      // 이미 선택된 옵션인 경우 수량만 +1
      if (selectedOptions.has(optionKey)) {
          const item = selectedOptions.get(optionKey);
          updateQuantity(optionKey, item.quantity + 1);
          return;
      }

      // 신규 옵션 추가
      selectedOptions.set(optionKey, { color, size, quantity: 1, price: price + addPrice });
      renderOptionCards();
      calculateTotal();
  }

  /**
   * 2. 선택된 옵션 목록 UI 렌더링
   */
  function renderOptionCards() {
      optionListContainer.innerHTML = '';

      selectedOptions.forEach((item, key) => {
          const itemTotalPrice = (item.price * item.quantity).toLocaleString();
          
          const card = document.createElement('div');
          card.className = 'selected-option-card';
          card.dataset.key = key;
          card.innerHTML = `
              <div class="option-info">
                  <b class="selected-option-name">${item.color} / ${item.size}</b>
                  <!-- onclick 대신 data-action 및 data-key 사용 -->
                  <button type="button" class="btn-delete" data-action="delete" data-key="${key}">✕</button>
              </div>
              <div class="option-controls">
                  <div class="quantity-wrap">
                      <button type="button" data-action="minus" data-key="${key}">-</button>
                      <input type="number" class="quantity-input" value="${item.quantity}" min="1" max="999" readonly>
                      <button type="button" data-action="plus" data-key="${key}">+</button>
                  </div>
                  <span class="option-price">${itemTotalPrice}원</span>
              </div>
          `;
          optionListContainer.appendChild(card);
      });
  }

  /**
   * 3. 수량 변경 처리
   */
  function changeQty(key, delta) {
      const item = selectedOptions.get(key);
      if (!item) return;
      
      const newQty = item.quantity + delta;
      if (newQty >= 1 && newQty <= 999) {
          updateQuantity(key, newQty);
      }
  }

  function updateQuantity(key, newQty) {
      const item = selectedOptions.get(key);
      item.quantity = newQty;
      renderOptionCards();
      calculateTotal();
  }

  /**
   * 4. 옵션 카드 삭제
   */
  function removeOption(key) {
      selectedOptions.delete(key);
      renderOptionCards();
      calculateTotal();
  }

  /**
   * 5. 총 가격 계산 및 버튼 활성화 제어
   */
  function calculateTotal() {
      let total = 0;
      selectedOptions.forEach(item => {
          total += item.price * item.quantity;
      });

      totalPriceEl.textContent = `${total.toLocaleString()}원`;

      // 선택된 옵션이 없으면 버튼 비활성화
      const isDisabled = selectedOptions.size === 0;
      cartBtn.disabled = isDisabled;
      buyBtn.disabled = isDisabled;
  }
  
  // 리스너를 한 번만 등록해두면, 동적으로 추가되는 버튼도 모두 정상 작동합니다.
  optionListContainer.addEventListener('click', (e) => {
      const btn = e.target.closest('button');
      if (!btn) return;

      const action = btn.dataset.action;
      const key = btn.dataset.key;

      if (action === 'minus') {
          changeQty(key, -1);
      } else if (action === 'plus') {
          changeQty(key, 1);
      } else if (action === 'delete') {
          removeOption(key);
      }
  });

  /**
   * 6. 장바구니 / 바로구매 데이터 전송
   */
  function sendOrderData(actionType) {
      if (selectedOptions.size === 0) return;

      // 전송할 데이터 구조 형성
      const payload = {
          action: actionType, // 'cart' 또는 'buy'
          items: Array.from(selectedOptions.entries()).map(([key, item]) => ({
              color: item.color,
              size: item.size,
              quantity: item.quantity,
              itemTotalPrice: item.price * item.quantity
          })),
          grandTotal: Array.from(selectedOptions.values()).reduce((sum, item) => sum + (item.price * item.quantity), 0)
      };

      console.log('전송 데이터:', payload);

      // 예시: fetch를 통한 서버 API 호출
      /*
      fetch('/order/process', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(payload)
      })
      .then(res => res.json())
      .then(data => {
          if(actionType === 'cart') alert('장바구니에 담겼습니다.');
          else location.href = '/checkout';
      });
      */
  }

  // 버튼 클릭 이벤트 바인딩
  cartBtn.addEventListener('click', () => sendOrderData('cart'));
  buyBtn.addEventListener('click', () => sendOrderData('buy'));

  // [테스트용] 임시로 옵션을 선택해 추가해보는 코드 (기존 모달 선택 완료 시점에 이 함수를 호출하세요)
  // addSelectedOption('블랙', '260');
  // addSelectedOption('화이트', '270');
  
  
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
  
  document.querySelectorAll(".reviewmodal-backdrop").forEach(function (modal) {
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
  
  document.addEventListener("keydown", function (event) {
    if (event.key === "Escape") {
      document.querySelectorAll(".reviewmodal-backdrop.open").forEach(function (modal) {
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

  
  var allReviewButton = document.getElementById("allReviewButton");
  var prodId = allReviewButton.dataset.prodId;
  if (allReviewButton) {
    allReviewButton.addEventListener("click", function () {
		
		const url = "detail/review";
		const params = {prodId: prodId};

		console.log(params);

		const fn = function(data){
			console.log(data.reviews);
			console.log(data.reviews.contents);
			
			
		const reviewModalContainer = document.getElementById("reviewGrid");
		reviewModalContainer.innerHTML = "";

		if( ! data|| data.length === 0){
			reviewModalContainer.innerHTML = "<p>현재 등록된 리뷰가 없는 상품입니다.</p>";
		}else{
			// 전체 HTML을 담을 빈 문자열 변수 생성
			let htmlString = '';

			for (let el of data.reviews) {
			    // 예: el.rating이 3이라면 '★★★☆☆'
			    let stars = '★'.repeat(el.rating) + '☆'.repeat(5 - el.rating);
			    
				// 완성된 형태의 HTML 문자열을 백틱(`) 안에 작성
				    htmlString += `			
				    <article class="review-card">
				        <div class="review-card-head">
				            <b>${stars}</b>
				        </div>
				        <p>${el.contents}</p>
				        <div class="review-img-list">`; // 이미지들을 감싸줄 영역 추가
				        
				        for (let imgs of el.imageList) {
				            if ("files" in imgs) {
				                // review-img 클래스 추가
				                htmlString += `<img src="${contextPath}/uploads/product/${imgs.files}" class="review-img" alt="리뷰 이미지">`;
				            }
				        }	
				        
				    // 백틱 위치와 구문 수정
				    htmlString += `
				        </div>
				        <small>${el.memberName} · ${el.color} · ${el.prodSize}mm · ${el.updatedAt}</small>
				    </article>`;
			}

			// 반복문이 끝난 후 완성된 HTML 문자열을 DOM에 한 번만 추가
			reviewModalContainer.innerHTML += htmlString;

		}
			openModal(reviewModal);
		  }

		  ajaxRequest(url, 'get', params, 'json', fn);
    });
  }
  
  var allQnAButton = document.getElementById("allQnAButton");
  if (allQnAButton) {
    allReviewButton.addEventListener("click", function () {
      
    });
  }
  
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
