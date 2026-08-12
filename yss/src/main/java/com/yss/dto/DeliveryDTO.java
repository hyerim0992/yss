package com.yss.dto;

public class DeliveryDTO {
	// erd 초록색 테이블
	
	private String deievery; // 택배사
	private String trackingNo;
	private String receiver;
	private String receiverNo;
	private String addr1; // 기본주소
	private String addr2; // 상세주소
	private String zipcode; // 우편번호
	private String dlvStatus; // 배송상태
	private String shippedAt;
	private String deliveredAt;
	private String memo;
	
	private long addressId;
	private String isDefault; // 기본배송지 여부
	
	public String getDeievery() {
		return deievery;
	}
	public void setDeievery(String deievery) {
		this.deievery = deievery;
	}
	public String getTrackingNo() {
		return trackingNo;
	}
	public void setTrackingNo(String trackingNo) {
		this.trackingNo = trackingNo;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getReceiverNo() {
		return receiverNo;
	}
	public void setReceiverNo(String receiverNo) {
		this.receiverNo = receiverNo;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getDlvStatus() {
		return dlvStatus;
	}
	public void setDlvStatus(String dlvStatus) {
		this.dlvStatus = dlvStatus;
	}
	public String getShippedAt() {
		return shippedAt;
	}
	public void setShippedAt(String shippedAt) {
		this.shippedAt = shippedAt;
	}
	public String getDeliveredAt() {
		return deliveredAt;
	}
	public void setDeliveredAt(String deliveredAt) {
		this.deliveredAt = deliveredAt;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public long getAddressId() {
		return addressId;
	}
	public void setAddressId(long addressId) {
		this.addressId = addressId;
	}
	public String getIsDefault() {
		return isDefault;
	}
	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}
	
	
	
}
