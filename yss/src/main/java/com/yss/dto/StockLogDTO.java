package com.yss.dto;

public class StockLogDTO {
	// erd 황색 테이블
	
	private long logId;
	private long optionId;
	private long orderItemId;
	private String changeType; // 변동유형
	
	private int changeQuantity; // 변동 수량
	private int changedStock; // 변동 후 수량
	private String changeDate; // 변동 일시
	
	private long containerId;
	private String zone;
	
	
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
	public long getOptionId() {
		return optionId;
	}
	public void setOptionId(long optionId) {
		this.optionId = optionId;
	}
	public long getOrderItemId() {
		return orderItemId;
	}
	public void setOrderItemId(long orderItemId) {
		this.orderItemId = orderItemId;
	}
	public int getChangedStock() {
		return changedStock;
	}
	public void setChangedStock(int changedStock) {
		this.changedStock = changedStock;
	}
	
	
}
