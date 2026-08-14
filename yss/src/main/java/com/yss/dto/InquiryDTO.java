package com.yss.dto;

public class InquiryDTO {
		private long inquiryId;   
		private long memberId;
		private String inquiryType;
		private String title;     
		private String content;   
		private String status;    
		private String createdAt;
		
		public long getInquiryId() {
			return inquiryId;
		}
		public void setInquiryId(long inquiryId) {
			this.inquiryId = inquiryId;
		}
		public long getMemberId() {
			return memberId;
		}
		public void setMemberId(long memberId) {
			this.memberId = memberId;
		}
		public String getInquiryType() {
			return inquiryType;
		}
		public void setInquiryType(String inquiryType) {
			this.inquiryType = inquiryType;
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
}
