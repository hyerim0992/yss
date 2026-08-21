package com.yss.dto;

public class MemberDTO {
	private Long memberId;
	private String userId;
	private String password;
	private int role;
	private String status;
	private String createAt;
	private String updateAt;
	private String deleteAt;
	private String name;
	private String email;
	private String phone;
	private String birth;
	private String zip;
	private String addr1;
	private String addr2;
	private String refundAccount;
	private String bankName;
	private String accountHolder;
	private Long sanctionId;
	private String sanctionReason;
	private String sanctionStartDate;
	private String sanctionEndDate;
	private String sanctionStatus;

	public Long getMemberId() {
		return memberId;
	}
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getRole() {
		return role;
	}
	public void setRole(int role) {
		this.role = role;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreateAt() {
		return createAt;
	}
	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}
	public String getUpdateAt() {
		return updateAt;
	}
	public void setUpdateAt(String updateAt) {
		this.updateAt = updateAt;
	}
	public String getDeleteAt() {
		return deleteAt;
	}
	public void setDeleteAt(String deleteAt) {
		this.deleteAt = deleteAt;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
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
	public String getRefundAccount() {
		return refundAccount;
	}
	public void setRefundAccount(String refundAccount) {
		this.refundAccount = refundAccount;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getAccountHolder() {
		return accountHolder;
	}
	public void setAccountHolder(String accountHolder) {
		this.accountHolder = accountHolder;
	}
	public Long getSanctionId() {
	    return sanctionId;
	}

	public void setSanctionId(Long sanctionId) {
	    this.sanctionId = sanctionId;
	}

	public String getSanctionReason() {
	    return sanctionReason;
	}

	public void setSanctionReason(String sanctionReason) {
	    this.sanctionReason = sanctionReason;
	}

	public String getSanctionStartDate() {
	    return sanctionStartDate;
	}

	public void setSanctionStartDate(String sanctionStartDate) {
	    this.sanctionStartDate = sanctionStartDate;
	}

	public String getSanctionEndDate() {
	    return sanctionEndDate;
	}

	public void setSanctionEndDate(String sanctionEndDate) {
	    this.sanctionEndDate = sanctionEndDate;
	}

	public String getSanctionStatus() {
	    return sanctionStatus;
	}

	public void setSanctionStatus(String sanctionStatus) {
	    this.sanctionStatus = sanctionStatus;
	}
}
