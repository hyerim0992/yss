package com.yss.dto;

public class wishListDTO {
	private Long wishListId;
	private String cratedAt;
	private Long productId;
	private Long memberId;
	
	private ProductDTO product;
	
	public ProductDTO getProduct() {
		return product;
	}
	public void setProduct(ProductDTO product) {
		this.product = product;
	}
	public Long getWishListId() {
		return wishListId;
	}
	public void setWishListId(Long wishListId) {
		this.wishListId = wishListId;
	}
	public String getCratedAt() {
		return cratedAt;
	}
	public void setCratedAt(String cratedAt) {
		this.cratedAt = cratedAt;
	}
	public Long getProductId() {
		return productId;
	}
	public void setProductId(Long productId) {
		this.productId = productId;
	}
	public Long getMemberId() {
		return memberId;
	}
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	
}