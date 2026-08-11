(function ($)
  { "use strict"
  
/* 기능 설명 */
    // 혹시 로딩 화면이 남아 있더라도 문서가 열리면 즉시 제거한다.
    $(function () {
      $('#preloader-active').remove();
      $('body').css('overflow', 'visible');
    });


/* 기능 설명 */
    function mainSlider() {
      var BasicSlider = $('.slider-active');
      BasicSlider.on('init', function (e, slick) {
        var $firstAnimatingElements = $('.single-slider:first-child').find('[data-animation]');
        doAnimations($firstAnimatingElements);
      });
      BasicSlider.on('beforeChange', function (e, slick, currentSlide, nextSlide) {
        var $animatingElements = $('.single-slider[data-slick-index="' + nextSlide + '"]').find('[data-animation]');
        doAnimations($animatingElements);
      });
      BasicSlider.slick({
        autoplay: false,
        autoplaySpeed: 10000,
        dots: false,
        fade: true,
        arrows: false,
        prevArrow: '<button type="button" class="slick-prev"><i class="ti-shift-left"></i></button>',
        nextArrow: '<button type="button" class="slick-next"><i class="ti-shift-right"></i></button>',
        responsive: [{
            breakpoint: 1024,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1,
              infinite: true,
            }
          },
          {
            breakpoint: 991,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1,
              arrows: false
            }
          },
          {
            breakpoint: 767,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1,
              arrows: false
            }
          }
        ]
      });

      function doAnimations(elements) {
        var animationEndEvents = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
        elements.each(function () {
          var $this = $(this);
          var $animationDelay = $this.data('delay');
          var $animationType = 'animated ' + $this.data('animation');
          $this.css({
            'animation-delay': $animationDelay,
            '-webkit-animation-delay': $animationDelay
          });
          $this.addClass($animationType).one(animationEndEvents, function () {
            $this.removeClass($animationType);
          });
        });
      }
    }
    mainSlider();



/* 기능 설명 */
  var testimonial = $('.h1-testimonial-active');
    if(testimonial.length){
    testimonial.slick({
        dots: false,
        infinite: true,
        speed: 1000,
        autoplay:false,
        loop:true,
        arrows: true,
        prevArrow: '<button type="button" class="slick-prev"><i class="ti-angle-left"></i></button>',
        nextArrow: '<button type="button" class="slick-next"><i class="ti-angle-right"></i></button>',
        slidesToShow: 1,
        slidesToScroll: 1,
        responsive: [
          {
            breakpoint: 1024,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1,
              infinite: true,
              dots: false,
              arrow:false
            }
          },
          {
            breakpoint: 600,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1,
              arrows:false
            }
          },
          {
            breakpoint: 480,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1,
              arrows:false,
            }
          }
        ]
      });
    }


/* 기능 설명 */
    var client_list = $('.completed-active');
    if(client_list.length){
      client_list.owlCarousel({
        slidesToShow: 2,
        slidesToScroll: 1,
        loop: true,
        autoplay:true,
        speed: 3000,
        smartSpeed:2000,
        nav: false,
        dots: false,
        margin: 15,

        autoplayHoverPause: true,
        responsive : {
          0 : {
            items: 1
          },
          768 : {
            items: 2
          },
          992 : {
            items: 2
          },
          1200:{
            items: 3
          }
        }
      });
    }


/* 기능 설명 */
  var nice_Select = $('select');
    if(nice_Select.length){
      nice_Select.niceSelect();
    }





/* 기능 설명 */
    $.scrollUp({
      scrollName: 'scrollUp', // Element ID
      topDistance: '300', // Distance from top before showing element (px)
      topSpeed: 300, // Speed back to top (ms)
      animation: 'fade', // Fade, slide, none
      animationInSpeed: 200, // Animation in speed (ms)
      animationOutSpeed: 200, // Animation out speed (ms)
      scrollText: '<i class="ti-arrow-up"></i>', // Text for element
      activeOverlay: false, // Set CSS color to display scrollUp active point, e.g '#00FFFF'
    });


/* 기능 설명 */
    $("[data-background]").each(function () {
      $(this).css("background-image", "url(" + $(this).attr("data-background") + ")")
      });


/* 기능 설명 */
    new WOW().init();

/* 기능 설명 */
    
// 기능 설명
    function mailChimp() {
      $('#mc_embed_signup').find('form').ajaxChimp();
    }
    mailChimp();


// 기능 설명
    var popUp = $('.single_gallery_part, .img-pop-up');
      if(popUp.length){
        popUp.magnificPopup({
          type: 'image',
          gallery:{
            enabled:true
          }
        });
      }







/* 기능 설명 */


  $('.popup-youtube, .popup-vimeo').magnificPopup({
// 기능 설명
    type: 'iframe',
    mainClass: 'mfp-fade',
    removalDelay: 160,
    preloader: false,
    fixedContentPos: false
  });

  var review = $('.client_review_slider');
  if (review.length) {
    review.owlCarousel({
      items: 1,
      loop: true,
      dots: true,
      autoplay: true,
      autoplayHoverPause: true,
      autoplayTimeout: 5000,
      nav: true,
      dots: false,
      navText: [" <i class='ti-angle-left'></i> ", "<i class='ti-angle-right'></i> "],
      responsive: {
        0: {
          nav: false
        },
        768: {
          nav: false
        },
        991: {
          nav: true
        }
      }
    });
  }


  var product_slide = $('.product_img_slide');
  if (product_slide.length) {
    product_slide.owlCarousel({
      items: 1,
      loop: true,
      dots: true,
      autoplay: true,
      autoplayHoverPause: true,
      autoplayTimeout: 5000,
      nav: true,
      dots: false,
      navText: [" <i class='ti-angle-left'></i> ", "<i class='ti-angle-right'></i> "],
      responsive: {
        0: {
          nav: false
        },
        768: {
          nav: false
        },
        991: {
          nav: true
        }
      }
    });
  }

// 기능 설명
  var product_list_slider = $('.product_list_slider');
  if (product_list_slider.length) {
    product_list_slider.owlCarousel({
      items: 1,
      loop: true,
      dots: false,
      autoplay: true,
      autoplayHoverPause: true,
      autoplayTimeout: 5000,
            nav: true,
            navText: ["next", "previous"],
            smartSpeed: 1000,
            responsive: {
              0: {
                margin: 15,
                nav: false,
                items: 1
              },
              600: {
                margin: 15,
                items: 1,
                nav: false
              },
              768: {
                margin: 30,
                nav: true,
                items: 1
              }
            }
          });
        }

        if ($('.img-gal').length > 0) {
          $('.img-gal').magnificPopup({
            type: 'image',
            gallery: {
              enabled: true
            }
          });
        }

// 기능 설명
        $(document).ready(function () {
          $('select').niceSelect();
        });

// 기능 설명
        

// 기능 설명
// 기능 설명
// 기능 설명

        $('.slider').slick({
          slidesToShow: 1,
          slidesToScroll: 1,
          arrows: false,
          speed: 300,
          infinite: true,
          asNavFor: '.slider-nav-thumbnails',
          autoplay: true,
          pauseOnFocus: true,
          dots: true,
        });

        $('.slider-nav-thumbnails').slick({
          slidesToShow: 3,
          slidesToScroll: 1,
          asNavFor: '.slider',
          focusOnSelect: true,
          infinite: true,
          prevArrow: false,
          nextArrow: false,
          centerMode: true,
          responsive: [{
            breakpoint: 480,
            settings: {
              centerMode: false,
            }
          }]
        });


// 기능 설명
        $("#search_input_box").hide();
        $("#search_1").on("click", function () {
          $("#search_input_box").slideToggle();
          $("#search_input").focus();
        });
        $("#close_search").on("click", function () {
          $('#search_input_box').slideUp(500);
        });

// 기능 설명
        function mailChimp() {
          $('#mc_embed_signup').find('form').ajaxChimp();
        }
        mailChimp();

// 기능 설명
        function makeTimer() {

// 기능 설명
          var endTime = new Date("27 Sep 2019 12:56:00 GMT+01:00");
          endTime = (Date.parse(endTime) / 1000);

          var now = new Date();
          now = (Date.parse(now) / 1000);

          var timeLeft = endTime - now;

          var days = Math.floor(timeLeft / 86400);
          var hours = Math.floor((timeLeft - (days * 86400)) / 3600);
          var minutes = Math.floor((timeLeft - (days * 86400) - (hours * 3600)) / 60);
          var seconds = Math.floor((timeLeft - (days * 86400) - (hours * 3600) - (minutes * 60)));

          if (hours < "10") {
            hours = "0" + hours;
          }
          if (minutes < "10") {
            minutes = "0" + minutes;
          }
          if (seconds < "10") {
            seconds = "0" + seconds;
          }

          $("#days").html("<span>Days</span>" + days);
          $("#hours").html("<span>Hours</span>" + hours);
          $("#minutes").html("<span>Minutes</span>" + minutes);
          $("#seconds").html("<span>Seconds</span>" + seconds);

        }
// 기능 설명
      (function() {
      
        window.inputNumber = function(el) {

          var min = el.attr('min') || false;
          var max = el.attr('max') || false;

          var els = {};

          els.dec = el.prev();
          els.inc = el.next();

          el.each(function() {
            init($(this));
          });

          function init(el) {

            els.dec.on('click', decrement);
            els.inc.on('click', increment);

            function decrement() {
              var value = el[0].value;
              value--;
              if(!min || value >= min) {
                el[0].value = value;
              }
            }

            function increment() {
              var value = el[0].value;
              value++;
              if(!max || value <= max) {
                el[0].value = value++;
              }
            }
          }
        }
      })();

      inputNumber($('.input-number'));



        setInterval(function () {
          makeTimer();
        }, 1000);
      

      $('.select_option_dropdown').hide();
      $(".select_option_list").click(function () {
        $(this).parent(".select_option").children(".select_option_dropdown").slideToggle('100');
        $(this).find(".right").toggleClass("fas fa-caret-down, fas fa-caret-up");
      });

      if ($('.new_arrival_iner').length > 0) {
        var containerEl = document.querySelector('.new_arrival_iner');
        var mixer = mixitup(containerEl);
      }


      $('.controls').on('click', function(){
        $(this).addClass('active').siblings().removeClass('active');
      }); 


/* 기능 설명 */


})(jQuery);

/* 공통 검색 모달 로더: main.js를 사용하는 모든 화면에 검색 기능 연결 */
(function () {
  "use strict";

  if (window.__yongsinsaSearchLoaderStarted) return;
  window.__yongsinsaSearchLoaderStarted = true;

  function getContextPath() {
    var scripts = document.getElementsByTagName("script");
    var marker = "/dist/js/common/main.js";

    for (var i = scripts.length - 1; i >= 0; i -= 1) {
      var src = scripts[i].getAttribute("src") || "";
      var markerIndex = src.indexOf(marker);
      if (markerIndex !== -1) {
        try {
          var url = new URL(src, window.location.href);
          return url.pathname.substring(0, url.pathname.indexOf(marker));
        } catch (error) {
          return src.substring(0, markerIndex);
        }
      }
    }

    return "";
  }

  function loadStyle(contextPath) {
    if (document.querySelector('link[data-global-search-style]')) return;

    var link = document.createElement("link");
    link.rel = "stylesheet";
    link.href = contextPath + "/dist/css/pages/product/search.css";
    link.setAttribute("data-global-search-style", "true");
    document.head.appendChild(link);
  }

  function markSearchTriggers() {
    var selectors = [
      ".search-icon",
      '.form-box input[name="Search"]',
      '.form-box input[placeholder*="Search"]',
      "[data-search-open]"
    ];

    var triggers = document.querySelectorAll(selectors.join(","));
    Array.prototype.forEach.call(triggers, function (trigger) {
      trigger.setAttribute("data-open-search", "true");

      if (trigger.tagName === "INPUT") {
        trigger.setAttribute("autocomplete", "off");
        trigger.setAttribute("readonly", "readonly");
        trigger.style.cursor = "pointer";
      }
    });
  }

  function loadSearchScript(contextPath) {
    if (document.querySelector('script[data-global-search-script]')) return;

    var script = document.createElement("script");
    script.src = contextPath + "/dist/js/pages/product/search.js";
    script.setAttribute("data-global-search-script", "true");
    document.body.appendChild(script);
  }

  function initialize() {
    var contextPath = getContextPath();
    document.body.setAttribute("data-context-path", contextPath);
    loadStyle(contextPath);
    markSearchTriggers();

    if (document.getElementById("globalSearch")) {
      loadSearchScript(contextPath);
      return;
    }

    fetch(contextPath + "/common/search-modal", { credentials: "same-origin" })
      .then(function (response) {
        if (!response.ok) throw new Error("검색 모달을 불러오지 못했습니다.");
        return response.text();
      })
      .then(function (html) {
        var wrapper = document.createElement("div");
        wrapper.innerHTML = html.trim();

        while (wrapper.firstChild) {
          document.body.appendChild(wrapper.firstChild);
        }

        loadSearchScript(contextPath);
      })
      .catch(function (error) {
        if (window.console && console.error) {
          console.error(error);
        }
      });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initialize);
  } else {
    initialize();
  }
})();
