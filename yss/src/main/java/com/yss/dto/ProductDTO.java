package com.yss.dto;

public class ProductDTO {
	// erd 청록색 테이블
	
	private long productId;
	private String prodName;
	private int price;
	private int discRate; // 할인율
	private String thumbail;
	private String brand;
	private int heelHeight;
	private String status; // 판매중, 재고없음
	
	private long imageId;
	private String files;
	private int sortOrder; // 사진 노출 순서

	private long optionId;
	private int prodSize;
	private String color;
	private int addPrice;
	
	private long categoryId;
	private long parentId;
	private String ctgName;
	private int depth;
	
	public long getProductId() {
		return productId;
	}
	public void setProductId(long productId) {
		this.productId = productId;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getDiscRate() {
		return discRate;
	}
	public void setDiscRate(int discRate) {
		this.discRate = discRate;
	}
	public String getThumbail() {
		return thumbail;
	}
	public void setThumbail(String thumbail) {
		this.thumbail = thumbail;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public int getHeelHeight() {
		return heelHeight;
	}
	public void setHeelHeight(int heelHeight) {
		this.heelHeight = heelHeight;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public long getImageId() {
		return imageId;
	}
	public void setImageId(long imageId) {
		this.imageId = imageId;
	}
	public String getFiles() {
		return files;
	}
	public void setFiles(String files) {
		this.files = files;
	}
	public int getSortOrder() {
		return sortOrder;
	}
	public void setSortOrder(int sortOrder) {
		this.sortOrder = sortOrder;
	}
	public long getOptionId() {
		return optionId;
	}
	public void setOptionId(long optionId) {
		this.optionId = optionId;
	}
	public int getProdSize() {
		return prodSize;
	}
	public void setProdSize(int prodSize) {
		this.prodSize = prodSize;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public int getAddPrice() {
		return addPrice;
	}
	public void setAddPrice(int addPrice) {
		this.addPrice = addPrice;
	}
	public long getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(long categoryId) {
		this.categoryId = categoryId;
	}
	public long getParentId() {
		return parentId;
	}
	public void setParentId(long parentId) {
		this.parentId = parentId;
	}
	public String getCtgName() {
		return ctgName;
	}
	public void setCtgName(String ctgName) {
		this.ctgName = ctgName;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	
	
	
	
}
