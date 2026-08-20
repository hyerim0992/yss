package com.yss.dto;

import java.util.List;

public class ReviewDTO {
	private long orderItemId;
	private long productId;
	private int rating;
	private String contents;
	private String status;
	private String createdAt;
	private String updatedAt;
	
    private String memberName; 
    private String prodSize;
    private String color;
    
    private List<ReviewImageDTO> imageList;
	
	public long getOrderItemId() {
		return orderItemId;
	}
	public void setOrderItemId(long orderItemId) {
		this.orderItemId = orderItemId;
	}
	public long getProductId() {
		return productId;
	}
	public void setProductId(long productId) {
		this.productId = productId;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public String getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(String updatedAt) {
		this.updatedAt = updatedAt;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getProdSize() {
		return prodSize;
	}
	public void setProdSize(String prodSize) {
		this.prodSize = prodSize;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public List<ReviewImageDTO> getImageList() {
		return imageList;
	}
	public void setImageList(List<ReviewImageDTO> imageList) {
		this.imageList = imageList;
	}
	
}

/*
 * CREATE TABLE "YSS"."REVIEW" ( "ORDERITEMID" NUMBER NOT NULL ENABLE,
 * "PRODUCTID" NUMBER NOT NULL ENABLE, "RATING" NUMBER(1,0) NOT NULL ENABLE,
 * "CONTENTS" CLOB NOT NULL ENABLE, "STATUS" VARCHAR2(30 BYTE) DEFAULT 'PUBLIC'
 * NOT NULL ENABLE, "CREATEDAT" DATE DEFAULT SYSDATE NOT NULL ENABLE,
 * "UPDATEDAT" DATE )
 */
