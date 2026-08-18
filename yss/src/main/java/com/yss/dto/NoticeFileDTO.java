package com.yss.dto;

public class NoticeFileDTO {
	private Long fileId;
	private Long noticeId;
	private String files;
	private String serverFiles;
	public Long getFileId() {
		return fileId;
	}
	public void setFileId(Long fileId) {
		this.fileId = fileId;
	}
	public Long getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(Long noticeId) {
		this.noticeId = noticeId;
	}
	public String getFiles() {
		return files;
	}
	public void setFiles(String files) {
		this.files = files;
	}
	public String getServerFiles() {
		return serverFiles;
	}
	public void setServerFiles(String serverFiles) {
		this.serverFiles = serverFiles;
	}
}
