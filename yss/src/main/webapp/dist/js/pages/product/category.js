(function () {
    "use strict";

    var CART_STORAGE_KEY = "yongsinsaCart";
    var toastTimer = null;

    function readCart() {
        try {
            var saved = window.localStorage.getItem(CART_STORAGE_KEY);
            var parsed = saved ? JSON.parse(saved) : [];
            return Array.isArray(parsed) ? parsed : [];
        } catch (error) {
            return [];
        }
    }

    function saveCart(cart) {
        try {
            window.localStorage.setItem(CART_STORAGE_KEY, JSON.stringify(cart));
            return true;
        } catch (error) {
            return false;
        }
    }

    function getCartQuantity(cart) {
        return cart.reduce(function (total, item) {
            var quantity = Number(item.quantity) || 1;
            return total + quantity;
        }, 0);
    }

    function updateCartCount(cart) {
        var count = getCartQuantity(cart);
        document.querySelectorAll("[data-cart-count]").forEach(function (element) {
            element.textContent = String(count).padStart(2, "0");
        });
    }

    function showCartToast(message) {
        var toast = document.getElementById("ysCartToast");
        if (!toast) return;

        var text = toast.querySelector("span");
        if (text) text.textContent = message;

        toast.classList.add("is-visible");
        toast.setAttribute("aria-hidden", "false");

        window.clearTimeout(toastTimer);
        toastTimer = window.setTimeout(function () {
            toast.classList.remove("is-visible");
            toast.setAttribute("aria-hidden", "true");
        }, 2600);
    }

    function addToCart(button) {
        var product = {
            id: button.getAttribute("data-product-id") || "",
            name: button.getAttribute("data-product-name") || "상품",
            brand: button.getAttribute("data-product-brand") || "",
            price: Number(button.getAttribute("data-product-price")) || 0,
            image: button.getAttribute("data-product-image") || "",
            size: button.getAttribute("data-product-size") || "",
            quantity: 1
        };

        var cart = readCart();
        var existing = cart.find(function (item) {
            return String(item.id) === String(product.id) && String(item.size || "") === String(product.size || "");
        });

        if (existing) {
            existing.quantity = (Number(existing.quantity) || 1) + 1;
        } else {
            cart.push(product);
        }

        if (!saveCart(cart)) {
            window.alert("브라우저 저장 공간을 사용할 수 없어 장바구니에 담지 못했습니다.");
            return;
        }

        updateCartCount(cart);
        button.classList.add("is-added");
        button.setAttribute("aria-label", "장바구니에 담김");
        showCartToast(product.name + " 상품을 장바구니에 담았습니다.");
    }

    document.addEventListener("DOMContentLoaded", function () {
        var filterArea = document.querySelector(".ys-filter-area");
        var filterToggle = document.getElementById("ysFilterToggle");
        var FILTER_STATE_KEY = "yongsinsaCategoryFilterCollapsed";

        function setFilterCollapsed(collapsed, saveState) {
            if (!filterArea || !filterToggle) return;

            filterArea.classList.toggle("is-collapsed", collapsed);
            filterToggle.setAttribute("aria-expanded", collapsed ? "false" : "true");
            filterToggle.setAttribute("aria-label", collapsed ? "필터 펼치기" : "필터 접기");

            if (saveState) {
                try {
                    window.localStorage.setItem(FILTER_STATE_KEY, collapsed ? "1" : "0");
                } catch (error) {
                    // 저장소를 사용할 수 없어도 화면 동작은 유지한다.
                }
            }
        }

        if (filterArea && filterToggle) {
            var savedCollapsed = false;

            try {
                savedCollapsed = window.localStorage.getItem(FILTER_STATE_KEY) === "1";
            } catch (error) {
                savedCollapsed = false;
            }

            if (window.innerWidth > 991) {
                setFilterCollapsed(savedCollapsed, false);
            }

            filterToggle.addEventListener("click", function () {
                setFilterCollapsed(!filterArea.classList.contains("is-collapsed"), true);
            });
        }

        document.querySelectorAll(".ys-filter-head").forEach(function (head) {
            head.addEventListener("click", function () {
                var group = head.closest(".ys-filter-group");
                if (group) group.classList.toggle("open");
            });
        });

        var headerWish = document.querySelector(".header-wishlist-btn");
        if (headerWish) {
            headerWish.addEventListener("click", function (event) {
                event.preventDefault();
                var parent = headerWish.closest(".favorit-items");
                if (parent) parent.classList.toggle("active");
            });
        }

        updateCartCount(readCart());

        document.addEventListener("click", function (event) {
            var wishBtn = event.target.closest(".ys-wish-btn");
            var cartBtn = event.target.closest(".ys-cart-btn");

            if (wishBtn) {
                event.preventDefault();
                event.stopPropagation();
                wishBtn.classList.toggle("active");

                var icon = wishBtn.querySelector("i");
                if (icon) {
                    if (wishBtn.classList.contains("active")) {
                        icon.classList.remove("far");
                        icon.classList.add("fas");
                    } else {
                        icon.classList.remove("fas");
                        icon.classList.add("far");
                    }
                }
            }

            if (cartBtn) {
                event.preventDefault();
                event.stopPropagation();
                addToCart(cartBtn);
            }
        });
    });
})();
