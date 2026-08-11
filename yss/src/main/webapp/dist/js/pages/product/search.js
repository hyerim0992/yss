(function () {
  "use strict";

  if (window.__yongsinsaSearchInitialized) return;
  window.__yongsinsaSearchInitialized = true;

  var RECENT_KEY = "yongsinsaRecentSearches";
  var modal = document.getElementById("globalSearch");
  var modalInput = document.getElementById("globalSearchInput");

  function readRecentSearches() {
    try {
      var saved = JSON.parse(localStorage.getItem(RECENT_KEY) || "[]");
      return Array.isArray(saved) ? saved : [];
    } catch (error) {
      return [];
    }
  }

  function saveRecentSearch(keyword) {
    var word = String(keyword || "").trim();
    if (!word) return;

    var list = readRecentSearches().filter(function (item) {
      return item.toLowerCase() !== word.toLowerCase();
    });
    list.unshift(word);
    localStorage.setItem(RECENT_KEY, JSON.stringify(list.slice(0, 8)));
    renderRecentSearches();
  }

  function deleteRecentSearch(keyword) {
    var list = readRecentSearches().filter(function (item) {
      return item !== keyword;
    });
    localStorage.setItem(RECENT_KEY, JSON.stringify(list));
    renderRecentSearches();
  }

  function goToSearch(keyword) {
    var word = String(keyword || "").trim();
    if (!word) return;
    saveRecentSearch(word);
    var ctx = document.body.getAttribute("data-context-path") || "";
    window.location.href = ctx + "/product/search?q=" + encodeURIComponent(word);
  }

  function renderRecentSearches() {
    var lists = document.querySelectorAll("[data-recent-search-list]");
    var empties = document.querySelectorAll("[data-recent-search-empty]");
    var recent = readRecentSearches();

    Array.prototype.forEach.call(lists, function (list) {
      list.innerHTML = "";
      recent.forEach(function (keyword) {
        var chip = document.createElement("span");
        chip.className = "recent-search-chip";

        var wordButton = document.createElement("button");
        wordButton.type = "button";
        wordButton.className = "recent-search-chip__word";
        wordButton.textContent = keyword;
        wordButton.addEventListener("click", function () {
          goToSearch(keyword);
        });

        var removeButton = document.createElement("button");
        removeButton.type = "button";
        removeButton.className = "recent-search-chip__remove";
        removeButton.setAttribute("aria-label", keyword + " 최근 검색어 삭제");
        removeButton.textContent = "×";
        removeButton.addEventListener("click", function () {
          deleteRecentSearch(keyword);
        });

        chip.appendChild(wordButton);
        chip.appendChild(removeButton);
        list.appendChild(chip);
      });
    });

    Array.prototype.forEach.call(empties, function (empty) {
      empty.style.display = recent.length ? "none" : "block";
    });
  }

  function openSearch() {
    if (!modal) return;
    modal.classList.add("is-open");
    modal.setAttribute("aria-hidden", "false");
    document.body.classList.add("search-lock");
    renderRecentSearches();
    window.setTimeout(function () {
      if (modalInput) modalInput.focus();
    }, 220);
  }

  function closeSearch() {
    if (!modal) return;
    modal.classList.remove("is-open");
    modal.setAttribute("aria-hidden", "true");
    document.body.classList.remove("search-lock");
  }

  Array.prototype.forEach.call(document.querySelectorAll("[data-open-search]"), function (button) {
    button.addEventListener("click", openSearch);
  });

  Array.prototype.forEach.call(document.querySelectorAll("[data-search-close]"), function (button) {
    button.addEventListener("click", closeSearch);
  });

  Array.prototype.forEach.call(document.querySelectorAll("[data-global-search-form]"), function (form) {
    form.addEventListener("submit", function (event) {
      var input = form.querySelector("input[name='q']");
      var keyword = input ? input.value.trim() : "";
      if (!keyword) {
        event.preventDefault();
        if (input) input.focus();
        return;
      }
      saveRecentSearch(keyword);
    });
  });

  Array.prototype.forEach.call(document.querySelectorAll("[data-search-keyword]"), function (button) {
    button.addEventListener("click", function () {
      goToSearch(button.getAttribute("data-search-keyword"));
    });
  });

  Array.prototype.forEach.call(document.querySelectorAll("[data-clear-recent]"), function (button) {
    button.addEventListener("click", function () {
      localStorage.removeItem(RECENT_KEY);
      renderRecentSearches();
    });
  });

  document.addEventListener("keydown", function (event) {
    if (event.key === "Escape") closeSearch();
  });

  renderRecentSearches();

  var resultGrid = document.getElementById("searchProductGrid");
  if (!resultGrid) return;

  var products = [
    { id: 1, brand: "Adidas", name: "Samba OG Core Black", keywords: "아디다스 삼바 블랙 스니커즈", image: "product/product_list_1.png", price: 149000, popularity: 98, male: 94, female: 87, wish: 1230, review: 421, release: 20260801, category: "sneakers", gender: "unisex", color: "black", size: "255", delivery: "fast", soldout: false },
    { id: 2, brand: "Nike", name: "Air Force 1 '07 White", keywords: "나이키 에어포스 화이트 스니커즈", image: "product/product_list_2.png", price: 139000, popularity: 96, male: 91, female: 92, wish: 1580, review: 612, release: 20260720, category: "sneakers", gender: "unisex", color: "white", size: "260", delivery: "normal", soldout: false },
    { id: 3, brand: "New Balance", name: "530 Steel Grey", keywords: "뉴발란스 530 스틸그레이 러닝화", image: "product/product_list_3.png", price: 119000, popularity: 95, male: 84, female: 96, wish: 2110, review: 886, release: 20260711, category: "running", gender: "unisex", color: "gray", size: "240", delivery: "warehouse", soldout: false },
    { id: 4, brand: "Asics", name: "Gel-Kayano 14 Cream Black", keywords: "아식스 젤카야노 크림 블랙 러닝화", image: "product/product_list_4.png", price: 189000, popularity: 91, male: 95, female: 80, wish: 970, review: 302, release: 20260618, category: "running", gender: "men", color: "beige", size: "270", delivery: "overseas", soldout: false },
    { id: 5, brand: "Converse", name: "Chuck 70 Classic Black", keywords: "컨버스 척70 클래식 블랙 스니커즈", image: "product/product_list_5.png", price: 95000, popularity: 89, male: 85, female: 91, wish: 760, review: 234, release: 20260529, category: "sneakers", gender: "unisex", color: "black", size: "250", delivery: "fast", soldout: false },
    { id: 6, brand: "Adidas", name: "Ecliptain Cloud White", keywords: "아디다스 이클립테인 클라우드 화이트", image: "product/product_list_6.png", price: 79000, popularity: 82, male: 78, female: 86, wish: 660, review: 199, release: 20260510, category: "slipon", gender: "women", color: "white", size: "235", delivery: "normal", soldout: false },
    { id: 7, brand: "Nike", name: "Pegasus 41 Black", keywords: "나이키 페가수스 러닝화 블랙", image: "product/product_list_7.png", price: 159000, popularity: 87, male: 90, female: 82, wish: 540, review: 167, release: 20260424, category: "running", gender: "men", color: "black", size: "275", delivery: "fast", soldout: true },
    { id: 8, brand: "New Balance", name: "574 Legacy Beige", keywords: "뉴발란스 574 레거시 베이지", image: "product/product_list_8.png", price: 129000, popularity: 85, male: 79, female: 90, wish: 820, review: 275, release: 20260412, category: "sneakers", gender: "women", color: "beige", size: "245", delivery: "warehouse", soldout: false },
    { id: 9, brand: "Asics", name: "Gel-Nimbus 26 White", keywords: "아식스 젤님버스 화이트 러닝화", image: "product/product_list_9.png", price: 179000, popularity: 80, male: 82, female: 77, wish: 430, review: 143, release: 20260330, category: "running", gender: "unisex", color: "white", size: "265", delivery: "overseas", soldout: false },
    { id: 10, brand: "Converse", name: "Run Star Hike Low", keywords: "컨버스 런스타 하이크 로우", image: "product/product_list_10.png", price: 109000, popularity: 78, male: 73, female: 88, wish: 590, review: 188, release: 20260302, category: "sneakers", gender: "women", color: "black", size: "230", delivery: "normal", soldout: false }
  ];

  var queryInput = document.getElementById("searchPageQuery");
  var queryForm = document.getElementById("searchPageForm");
  var resultCount = document.getElementById("searchResultCount");
  var resultTitle = document.getElementById("searchResultTitle");
  var emptyState = document.getElementById("searchEmptyState");
  var sortSelect = document.getElementById("searchSort");
  var filterForm = document.getElementById("searchFilterForm");
  var resetButton = document.getElementById("searchFilterReset");
  var contextPath = document.body.getAttribute("data-context-path") || "";
  var params = new URLSearchParams(window.location.search);
  var currentQuery = (params.get("q") || "").trim();

  if (queryInput) queryInput.value = currentQuery;
  if (resultTitle) resultTitle.textContent = currentQuery ? "‘" + currentQuery + "’ 검색 결과" : "전체 상품 검색";

  function selectedValues(name) {
    return Array.prototype.map.call(document.querySelectorAll("input[name='" + name + "']:checked"), function (input) {
      return input.value;
    });
  }

  function matchesQuery(product) {
    if (!currentQuery) return true;
    var needle = currentQuery.toLowerCase().replace(/\s+/g, "");
    var haystack = (product.brand + product.name + product.keywords).toLowerCase().replace(/\s+/g, "");
    return haystack.indexOf(needle) !== -1;
  }

  function matchesFilters(product) {
    var groups = ["delivery", "category", "gender", "color", "brand", "size"];
    var matched = groups.every(function (name) {
      var values = selectedValues(name);
      if (!values.length) return true;
      var productValue = String(product[name]).toLowerCase();
      return values.some(function (value) { return value.toLowerCase() === productValue; });
    });

    if (!matched) return false;

    var prices = selectedValues("price");
    if (prices.length) {
      var priceMatched = prices.some(function (range) {
        if (range === "under100") return product.price < 100000;
        if (range === "100to150") return product.price >= 100000 && product.price < 150000;
        if (range === "over150") return product.price >= 150000;
        return true;
      });
      if (!priceMatched) return false;
    }

    var excludeSoldout = document.getElementById("excludeSoldout");
    if (excludeSoldout && excludeSoldout.checked && product.soldout) return false;
    return true;
  }

  function sortProducts(list) {
    var mode = sortSelect ? sortSelect.value : "recommend";
    var sorted = list.slice();
    var keyMap = { popular: "popularity", male: "male", female: "female", wish: "wish", review: "review", release: "release" };

    if (mode === "priceLow") sorted.sort(function (a, b) { return a.price - b.price; });
    else if (mode === "priceHigh") sorted.sort(function (a, b) { return b.price - a.price; });
    else if (keyMap[mode]) sorted.sort(function (a, b) { return b[keyMap[mode]] - a[keyMap[mode]]; });
    else sorted.sort(function (a, b) { return (b.popularity + b.wish / 100) - (a.popularity + a.wish / 100); });
    return sorted;
  }

  function formatPrice(price) {
    return new Intl.NumberFormat("ko-KR").format(price) + "원";
  }

  function deliveryLabel(code) {
    var labels = { fast: "빠른배송", overseas: "해외배송", normal: "일반배송", warehouse: "창고보관" };
    return labels[code] || code;
  }

  function renderProducts() {
    var filtered = products.filter(matchesQuery).filter(matchesFilters);
    filtered = sortProducts(filtered);
    resultGrid.innerHTML = "";

    filtered.forEach(function (product) {
      var article = document.createElement("article");
      article.className = "search-product-card";
      article.innerHTML =
        '<a href="' + contextPath + '/product/detail">' +
          '<div class="search-product-card__image">' +
            '<span class="search-product-card__badge">' + (product.soldout ? "품절" : deliveryLabel(product.delivery)) + '</span>' +
            '<img src="' + contextPath + '/dist/images/' + product.image + '" alt="' + product.brand + ' ' + product.name + '">' +
          '</div>' +
          '<div class="search-product-card__body">' +
            '<p class="search-product-card__brand">' + product.brand + '</p>' +
            '<h2 class="search-product-card__name">' + product.name + '</h2>' +
            '<p class="search-product-card__meta">관심 ' + new Intl.NumberFormat("ko-KR").format(product.wish) + ' · 리뷰 ' + product.review + '</p>' +
            '<div class="search-product-card__price"><strong>' + formatPrice(product.price) + '</strong><span>' + product.size + 'mm</span></div>' +
          '</div>' +
        '</a>';
      resultGrid.appendChild(article);
    });

    if (resultCount) resultCount.textContent = filtered.length;
    if (emptyState) emptyState.classList.toggle("is-visible", filtered.length === 0);
    resultGrid.style.display = filtered.length ? "grid" : "none";
  }

  if (queryForm) {
    queryForm.addEventListener("submit", function (event) {
      event.preventDefault();
      var keyword = queryInput ? queryInput.value.trim() : "";
      if (!keyword) return;
      saveRecentSearch(keyword);
      window.location.href = contextPath + "/product/search?q=" + encodeURIComponent(keyword);
    });
  }

  if (filterForm) filterForm.addEventListener("change", renderProducts);
  if (sortSelect) sortSelect.addEventListener("change", renderProducts);
  if (resetButton) {
    resetButton.addEventListener("click", function () {
      if (filterForm) filterForm.reset();
      if (sortSelect) sortSelect.value = "recommend";
      renderProducts();
    });
  }

  if (currentQuery) saveRecentSearch(currentQuery);
  renderProducts();
})();
