(function () {
  "use strict";

  function initializeSearchUi() {
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
      var list = readRecentSearches().filter(function (item) { return item !== keyword; });
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
      var template = document.getElementById("recentSearchChipTemplate");
      var recent = readRecentSearches();

      Array.prototype.forEach.call(lists, function (list) {
        list.replaceChildren();
        if (!template) return;
        recent.forEach(function (keyword) {
          var chip = template.content.cloneNode(true);
          var wordButton = chip.querySelector(".recent-search-chip__word");
          var removeButton = chip.querySelector(".recent-search-chip__remove");
          if (wordButton) {
            wordButton.textContent = keyword;
            wordButton.addEventListener("click", function () { goToSearch(keyword); });
          }
          if (removeButton) {
            removeButton.setAttribute("aria-label", keyword + " 최근 검색어 삭제");
            removeButton.addEventListener("click", function () { deleteRecentSearch(keyword); });
          }
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
      window.setTimeout(function () { if (modalInput) modalInput.focus(); }, 220);
    }

    function closeSearch() {
      if (!modal) return;
      modal.classList.remove("is-open");
      modal.setAttribute("aria-hidden", "true");
      document.body.classList.remove("search-lock");
    }

    Array.prototype.forEach.call(document.querySelectorAll("[data-open-search]"), function (button) {
      button.addEventListener("click", openSearch);
      if (button.getAttribute("role") === "button") {
        button.addEventListener("keydown", function (event) {
          if (event.key === "Enter" || event.key === " ") {
            event.preventDefault();
            openSearch();
          }
        });
      }
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
      button.addEventListener("click", function () { goToSearch(button.getAttribute("data-search-keyword")); });
    });
    Array.prototype.forEach.call(document.querySelectorAll("[data-clear-recent]"), function (button) {
      button.addEventListener("click", function () {
        localStorage.removeItem(RECENT_KEY);
        renderRecentSearches();
      });
    });
    document.addEventListener("keydown", function (event) { if (event.key === "Escape") closeSearch(); });
    renderRecentSearches();

    var resultGrid = document.getElementById("searchProductGrid");
    if (!resultGrid) return;

    var cards = Array.prototype.slice.call(resultGrid.querySelectorAll("[data-search-product]"));
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
      return Array.prototype.map.call(document.querySelectorAll("input[name='" + name + "']:checked"), function (input) { return input.value; });
    }
    function dataNumber(card, key) { return Number(card.dataset[key] || 0); }
    function matchesQuery(card) {
      if (!currentQuery) return true;
      var needle = currentQuery.toLowerCase().replace(/\s+/g, "");
      var haystack = (card.dataset.brand + card.dataset.name + card.dataset.keywords).toLowerCase().replace(/\s+/g, "");
      return haystack.indexOf(needle) !== -1;
    }
    function matchesFilters(card) {
      var groups = ["delivery", "category", "gender", "color", "brand", "size"];
      var matched = groups.every(function (name) {
        var values = selectedValues(name);
        if (!values.length) return true;
        var productValue = String(card.dataset[name] || "").toLowerCase();
        return values.some(function (value) { return value.toLowerCase() === productValue; });
      });
      if (!matched) return false;
      var prices = selectedValues("price");
      var price = dataNumber(card, "price");
      if (prices.length && !prices.some(function (range) {
        if (range === "under100") return price < 100000;
        if (range === "100to150") return price >= 100000 && price < 150000;
        if (range === "over150") return price >= 150000;
        return true;
      })) return false;
      var excludeSoldout = document.getElementById("excludeSoldout");
      if (excludeSoldout && excludeSoldout.checked && card.dataset.soldout === "true") return false;
      return true;
    }
    function sortCards(list) {
      var mode = sortSelect ? sortSelect.value : "recommend";
      var sorted = list.slice();
      var keyMap = { popular: "popularity", male: "male", female: "female", wish: "wish", review: "review", release: "release" };
      if (mode === "priceLow") sorted.sort(function (a,b) { return dataNumber(a,"price") - dataNumber(b,"price"); });
      else if (mode === "priceHigh") sorted.sort(function (a,b) { return dataNumber(b,"price") - dataNumber(a,"price"); });
      else if (keyMap[mode]) sorted.sort(function (a,b) { return dataNumber(b,keyMap[mode]) - dataNumber(a,keyMap[mode]); });
      else sorted.sort(function (a,b) { return (dataNumber(b,"popularity") + dataNumber(b,"wish")/100) - (dataNumber(a,"popularity") + dataNumber(a,"wish")/100); });
      return sorted;
    }
    function renderProducts() {
      var filtered = sortCards(cards.filter(matchesQuery).filter(matchesFilters));
      var visible = new Set(filtered);
      filtered.forEach(function (card) { resultGrid.appendChild(card); });
      cards.forEach(function (card) { card.hidden = !visible.has(card); });
      if (resultCount) resultCount.textContent = filtered.length;
      if (emptyState) emptyState.classList.toggle("is-visible", filtered.length === 0);
      resultGrid.style.display = filtered.length ? "grid" : "none";
    }
    if (queryForm) queryForm.addEventListener("submit", function (event) {
      event.preventDefault();
      var keyword = queryInput ? queryInput.value.trim() : "";
      if (!keyword) return;
      saveRecentSearch(keyword);
      window.location.href = contextPath + "/product/search?q=" + encodeURIComponent(keyword);
    });
    if (filterForm) filterForm.addEventListener("change", renderProducts);
    if (sortSelect) sortSelect.addEventListener("change", renderProducts);
    if (resetButton) resetButton.addEventListener("click", function () {
      if (filterForm) filterForm.reset();
      if (sortSelect) sortSelect.value = "recommend";
      renderProducts();
    });
    if (currentQuery) saveRecentSearch(currentQuery);
    renderProducts();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initializeSearchUi);
  } else {
    initializeSearchUi();
  }
})();
