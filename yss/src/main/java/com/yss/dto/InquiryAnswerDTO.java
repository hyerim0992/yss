package com.yss.dto;

public class InquiryAnswerDTO {
	private long answerId;        //PK
	private long inquiryId;      //FK
	private String answerer;
	private String content;
	private String createdAt;
	
	public long getAnswerId() {
		return answerId;
	}
	public void setAnswerId(long answerId) {
		this.answerId = answerId;
	}
	public long getInquiryId() {
		return inquiryId;
	}
	public void setInquiryId(long inquiryId) {
		this.inquiryId = inquiryId;
	}
	public String getAnswerer() {
		return answerer;
	}
	public void setAnswerer(String answerer) {
		this.answerer = answerer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	
}
