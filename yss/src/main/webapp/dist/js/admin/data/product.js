window.AdminPageKey = "product";
window.AdminPageData = {
      title: "상품관리",
      desc: "상품 등록·조회와 브랜드 정보를 관리합니다.",
      sections: [
        {
          name: "등록 상품 조회",
          table: "등록 상품 목록",
          addLabel: "+ 상품 등록",
          headers: [
            "물품번호",
            "상품명",
            "브랜드",
            "카테고리",
            "가격",
            "판매자",
            "판매자레벨",
            "등록일",
            "상태",
          ],
          filters: [
            {
              id: "productPeriod",
              type: "dateRange",
              label: "등록기간",
              column: 7,
            },
            {
              id: "sellerLevel",
              type: "select",
              label: "판매자레벨",
              column: 6,
              options: ["회원", "우수회원", "VIP", "판매자"],
            },
            {
              id: "productStatus",
              type: "select",
              label: "상품상태",
              column: 8,
              options: ["판매중", "품절"],
            },
          ],
          rows: [
            ["NK-AF1-001", "나이키 에어포스 1 '07", "NIKE", "스니커즈", "139,000원", "shoe_lab", "판매자", "2026-08-05", "판매중"],
            ["NB-993-002", "뉴발란스 993 그레이", "NEW BALANCE", "러닝화", "289,000원", "rare_kicks", "VIP", "2026-08-04", "판매중"],
            ["AD-SAM-003", "아디다스 삼바 OG", "ADIDAS", "스니커즈", "149,000원", "runner88", "우수회원", "2026-08-03", "품절"],
            ["AS-K14-004", "아식스 젤 카야노 14", "ASICS", "러닝화", "189,000원", "shoe_box", "판매자", "2026-08-02", "판매중"],
          ],
        },
        {
          name: "브랜드 관리",
          table: "브랜드 목록",
          addLabel: "+ 브랜드 등록",
          headers: [
            "브랜드코드",
            "브랜드명",
            "영문명",
            "등록상품수",
            "등록일",
            "상태",
          ],
          rows: [
            ["BR-NK", "나이키", "NIKE", "128개", "2026-05-10", "사용중"],
            ["BR-NB", "뉴발란스", "NEW BALANCE", "76개", "2026-05-10", "사용중"],
            ["BR-AD", "아디다스", "ADIDAS", "94개", "2026-05-11", "사용중"],
            ["BR-AS", "아식스", "ASICS", "42개", "2026-05-15", "사용중"],
          ],
        },
      ],
    };
