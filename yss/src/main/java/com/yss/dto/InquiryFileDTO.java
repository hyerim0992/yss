package com.yss.dto;

public class InquiryFileDTO {
	private long fileId;        
	private long inquiryId;     
	private String files;       
	private String serverfiles; 
	private long fileSize;
	
	public long getFileId() {
		return fileId;
	}
	public void setFileId(long fileId) {
		this.fileId = fileId;
	}
	public long getInquiryId() {
		return inquiryId;
	}
	public void setInquiryId(long inquiryId) {
		this.inquiryId = inquiryId;
	}
	public String getFiles() {
		return files;
	}
	public void setFiles(String files) {
		this.files = files;
	}
	public String getServerfiles() {
		return serverfiles;
	}
	public void setServerfiles(String serverfiles) {
		this.serverfiles = serverfiles;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	
}
