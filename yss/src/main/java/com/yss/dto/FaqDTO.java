package com.yss.dto;

public class FaqDTO {
	private Long faqId;
	private Long memberId;
	private String title;
	private String content;
	private String category;
	
	public Long getFaqId() {
		return faqId;
	}
	
	public void setFaqId(Long faqId) {
		this.faqId = faqId;
	}
	
	public Long getMemberId() {
		return memberId;
	}
	
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getCategory() {
		return category;
	}
	
	public void setCategory(String category) {
		this.category = category;
	}
}