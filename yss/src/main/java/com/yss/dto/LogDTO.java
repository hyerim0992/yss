package com.yss.dto;

public class LogDTO {
	// erd 황색 테이블
	
	private long inboundId;
	private int inboundQuantity;
	private int unitPrice; // 입고단가
	private String inboundDate;
	
	private long logId;
	private String changeType; // 변동유형
	private int changeQuantity;
	private String changeDate;
	
	private long containerId;
	private String zone;
	
	
	public long getInboundId() {
		return inboundId;
	}
	public void setInboundId(long inboundId) {
		this.inboundId = inboundId;
	}
	public int getInboundQuantity() {
		return inboundQuantity;
	}
	public void setInboundQuantity(int inboundQuantity) {
		this.inboundQuantity = inboundQuantity;
	}
	public int getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(int unitPrice) {
		this.unitPrice = unitPrice;
	}
	public String getInboundDate() {
		return inboundDate;
	}
	public void setInboundDate(String inboundDate) {
		this.inboundDate = inboundDate;
	}
	public long getLogId() {
		return logId;
	}
	public void setLogId(long logId) {
		this.logId = logId;
	}
	public String getChangeType() {
		return changeType;
	}
	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}
	public int getChangeQuantity() {
		return changeQuantity;
	}
	public void setChangeQuantity(int changeQuantity) {
		this.changeQuantity = changeQuantity;
	}
	public String getChangeDate() {
		return changeDate;
	}
	public void setChangeDate(String changeDate) {
		this.changeDate = changeDate;
	}
	public long getContainerId() {
		return containerId;
	}
	public void setContainerId(long containerId) {
		this.containerId = containerId;
	}
	public String getZone() {
		return zone;
	}
	public void setZone(String zone) {
		this.zone = zone;
	}
	
	
	
}
