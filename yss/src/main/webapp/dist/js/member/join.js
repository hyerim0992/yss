/* 회원가입 페이지 전용 스크립트: dist/js/join.js 로 복사 */
(function () {
    'use strict';

    var form = document.getElementById('joinForm');
    if (!form) return;

    var memberId = document.getElementById('memberId');
    var checkIdBtn = document.getElementById('checkIdBtn');
    var password = document.getElementById('password');
    var passwordConfirm = document.getElementById('passwordConfirm');
    var memberName = document.getElementById('memberName');
    var email = document.getElementById('email');
    var phone = document.getElementById('phone');
    var postalCode = document.getElementById('postalCode');
    var address = document.getElementById('address');
    var addressDetail = document.getElementById('addressDetail');
    var birthDate = document.getElementById('birthDate');
    var findAddressBtn = document.getElementById('findAddressBtn');
    var agreeAll = document.getElementById('agreeAll');
    var agreeItems = Array.prototype.slice.call(document.querySelectorAll('.ys-agree-item'));
    var requiredAgreements = Array.prototype.slice.call(document.querySelectorAll('.ys-required-agreement'));
    var checkedMemberId = '';

    function message(id, text, type) {
        var el = document.getElementById(id);
        if (!el) return;
        el.textContent = text || '';
        el.classList.remove('is-error', 'is-success');
        if (type) el.classList.add(type === 'success' ? 'is-success' : 'is-error');
    }

    function invalidate(input, messageId, text) {
        if (input) input.classList.add('ys-invalid');
        message(messageId, text, 'error');
        return false;
    }

    function validateId(showEmptyMessage) {
        var value = memberId.value.trim();
        var valid = /^[a-z0-9]{4,20}$/.test(value);
        memberId.classList.toggle('ys-invalid', !valid && (showEmptyMessage || value.length > 0));
        if (!valid && (showEmptyMessage || value.length > 0)) {
            message('memberIdMessage', '아이디는 영문 소문자와 숫자만 사용하여 4~20자로 입력해 주세요.', 'error');
        } else if (!value) {
            message('memberIdMessage', '', null);
        }
        return valid;
    }

    function validatePassword(showEmptyMessage) {
        var value = password.value;
        var valid = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[^A-Za-z\d\s]).{8,30}$/.test(value);
        password.classList.toggle('ys-invalid', !valid && (showEmptyMessage || value.length > 0));
        if (!valid && (showEmptyMessage || value.length > 0)) {
            message('passwordMessage', '영문, 숫자, 특수문자를 각각 1자 이상 포함한 8~30자로 입력해 주세요.', 'error');
        } else if (valid) {
            message('passwordMessage', '사용 가능한 비밀번호입니다.', 'success');
        } else {
            message('passwordMessage', '영문, 숫자, 특수문자를 각각 1자 이상 포함해 주세요.', null);
        }
        return valid;
    }

    function validatePasswordConfirm(showEmptyMessage) {
        var value = passwordConfirm.value;
        var valid = value.length > 0 && value === password.value;
        passwordConfirm.classList.toggle('ys-invalid', !valid && (showEmptyMessage || value.length > 0));
        if (!valid && (showEmptyMessage || value.length > 0)) {
            message('passwordConfirmMessage', '비밀번호가 일치하지 않습니다.', 'error');
        } else if (valid) {
            message('passwordConfirmMessage', '비밀번호가 일치합니다.', 'success');
        } else {
            message('passwordConfirmMessage', '', null);
        }
        return valid;
    }

    function validateName(showEmptyMessage) {
        var value = memberName.value.trim();
        var valid = /^[가-힣A-Za-z][가-힣A-Za-z\s]{1,29}$/.test(value);
        memberName.classList.toggle('ys-invalid', !valid && (showEmptyMessage || value.length > 0));
        message('memberNameMessage', !valid && (showEmptyMessage || value.length > 0) ? '이름을 2~30자로 입력해 주세요.' : '', !valid ? 'error' : null);
        return valid;
    }

    function validateEmail(showEmptyMessage) {
        var value = email.value.trim();
        var valid = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(value);
        email.classList.toggle('ys-invalid', !valid && (showEmptyMessage || value.length > 0));
        message('emailMessage', !valid && (showEmptyMessage || value.length > 0) ? '올바른 이메일 주소를 입력해 주세요.' : '', !valid ? 'error' : null);
        return valid;
    }

    function validatePhone(showEmptyMessage) {
        var value = phone.value.replace(/\D/g, '');
        var valid = /^01[016789]\d{7,8}$/.test(value);
        phone.classList.toggle('ys-invalid', !valid && (showEmptyMessage || value.length > 0));
        message('phoneMessage', !valid && (showEmptyMessage || value.length > 0) ? '올바른 휴대폰 번호를 입력해 주세요.' : '', !valid ? 'error' : null);
        return valid;
    }

    function validateAddress(showMessage) {
        var valid = !!postalCode.value.trim() && !!address.value.trim() && !!addressDetail.value.trim();
        postalCode.classList.toggle('ys-invalid', !postalCode.value.trim() && showMessage);
        address.classList.toggle('ys-invalid', !address.value.trim() && showMessage);
        addressDetail.classList.toggle('ys-invalid', !addressDetail.value.trim() && showMessage);
        message('addressMessage', !valid && showMessage ? '우편번호 찾기로 주소를 선택하고 상세주소를 입력해 주세요.' : '', !valid ? 'error' : null);
        return valid;
    }

    function validateBirthDate(showMessage) {
        var selected = birthDate.value ? new Date(birthDate.value + 'T00:00:00') : null;
        var today = new Date();
        today.setHours(0, 0, 0, 0);
        var min = new Date(today.getFullYear() - 120, today.getMonth(), today.getDate());
        var valid = selected && !isNaN(selected.getTime()) && selected <= today && selected >= min;
        birthDate.classList.toggle('ys-invalid', !valid && showMessage);
        message('birthDateMessage', !valid && showMessage ? '올바른 생년월일을 입력해 주세요.' : '', !valid ? 'error' : null);
        return !!valid;
    }

    function validateGender(showMessage) {
        var selected = form.querySelector('input[name="gender"]:checked');
        message('genderMessage', !selected && showMessage ? '성별을 선택해 주세요.' : '', !selected ? 'error' : null);
        return !!selected;
    }

    function validateAgreements(showMessage) {
        var valid = requiredAgreements.every(function (item) { return item.checked; });
        message('agreementMessage', !valid && showMessage ? '필수 약관에 모두 동의해 주세요.' : '', !valid ? 'error' : null);
        return valid;
    }

    function updateAgreeAll() {
        var selectedCount = agreeItems.filter(function (item) { return item.checked; }).length;
        agreeAll.checked = selectedCount === agreeItems.length;
        agreeAll.indeterminate = selectedCount > 0 && selectedCount < agreeItems.length;
        validateAgreements(false);
    }

    memberId.addEventListener('input', function () {
        checkedMemberId = '';
        validateId(false);
        if (memberId.value.trim()) message('memberIdMessage', '아이디 중복확인이 필요합니다.', null);
    });

    checkIdBtn.addEventListener('click', function () {
        var value = memberId.value.trim();
        if (!validateId(true)) {
            memberId.focus();
            return;
        }

        checkIdBtn.disabled = true;
        checkIdBtn.textContent = '확인 중';

        fetch(form.dataset.idCheckUrl + '?memberId=' + encodeURIComponent(value), {
            method: 'GET',
            headers: { 'Accept': 'application/json' },
            credentials: 'same-origin'
        })
            .then(function (response) {
                if (!response.ok) throw new Error('HTTP ' + response.status);
                return response.json();
            })
            .then(function (data) {
                if (memberId.value.trim() !== value) return;
                if (data.available === true) {
                    checkedMemberId = value;
                    memberId.classList.remove('ys-invalid');
                    message('memberIdMessage', '사용 가능한 아이디입니다.', 'success');
                } else {
                    checkedMemberId = '';
                    invalidate(memberId, 'memberIdMessage', data.message || '이미 사용 중인 아이디입니다.');
                    memberId.focus();
                }
            })
            .catch(function () {
                checkedMemberId = '';
                message('memberIdMessage', '중복확인 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.', 'error');
            })
            .then(function () {
                checkIdBtn.disabled = false;
                checkIdBtn.textContent = '중복확인';
            });
    });

    password.addEventListener('input', function () {
        validatePassword(false);
        if (passwordConfirm.value) validatePasswordConfirm(false);
    });
    passwordConfirm.addEventListener('input', function () { validatePasswordConfirm(false); });
    memberName.addEventListener('blur', function () { validateName(true); });
    email.addEventListener('blur', function () { validateEmail(true); });
    addressDetail.addEventListener('blur', function () { validateAddress(true); });
    birthDate.addEventListener('change', function () { validateBirthDate(true); });

    phone.addEventListener('input', function () {
        var numbers = phone.value.replace(/\D/g, '').slice(0, 11);
        if (numbers.length < 4) {
            phone.value = numbers;
        } else if (numbers.length < 8) {
            phone.value = numbers.slice(0, 3) + '-' + numbers.slice(3);
        } else if (numbers.length === 10) {
            phone.value = numbers.slice(0, 3) + '-' + numbers.slice(3, 6) + '-' + numbers.slice(6);
        } else {
            phone.value = numbers.slice(0, 3) + '-' + numbers.slice(3, 7) + '-' + numbers.slice(7);
        }
        validatePhone(false);
    });

    findAddressBtn.addEventListener('click', function () {
        if (!window.kakao || !window.kakao.Postcode) {
            message('addressMessage', '주소 검색 서비스를 불러오지 못했습니다. 인터넷 연결을 확인해 주세요.', 'error');
            return;
        }

        new window.kakao.Postcode({
            oncomplete: function (data) {
                var selectedAddress = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
                postalCode.value = data.zonecode;
                address.value = selectedAddress;
                postalCode.classList.remove('ys-invalid');
                address.classList.remove('ys-invalid');
                message('addressMessage', '', null);
                addressDetail.focus();
            }
        }).open();
    });

    agreeAll.addEventListener('change', function () {
        agreeItems.forEach(function (item) { item.checked = agreeAll.checked; });
        agreeAll.indeterminate = false;
        validateAgreements(false);
    });

    agreeItems.forEach(function (item) {
        item.addEventListener('change', updateAgreeAll);
    });

    Array.prototype.slice.call(form.querySelectorAll('input[name="gender"]')).forEach(function (radio) {
        radio.addEventListener('change', function () { validateGender(false); });
    });

    form.addEventListener('submit', function (event) {
        var idValid = validateId(true);
        var idChecked = checkedMemberId === memberId.value.trim();
        var validations = [
            idValid,
            idChecked,
            validatePassword(true),
            validatePasswordConfirm(true),
            validateName(true),
            validateEmail(true),
            validatePhone(true),
            validateAddress(true),
            validateBirthDate(true),
            validateGender(true),
            validateAgreements(true)
        ];

        if (!idChecked && idValid) {
            invalidate(memberId, 'memberIdMessage', '아이디 중복확인을 완료해 주세요.');
        }

        if (validations.some(function (valid) { return !valid; })) {
            event.preventDefault();
            var firstInvalid = form.querySelector('.ys-invalid');
            if (!firstInvalid && !validateGender(false)) firstInvalid = form.querySelector('input[name="gender"]');
            if (!firstInvalid && !validateAgreements(false)) firstInvalid = document.getElementById('agreeTerms');
            if (firstInvalid) firstInvalid.focus();
        }
    });

    var todayText = new Date().toISOString().slice(0, 10);
    birthDate.setAttribute('max', todayText);
    document.getElementById('currentYear').textContent = new Date().getFullYear();
})();
