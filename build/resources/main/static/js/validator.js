/**
 * 값 입력 여부
 * @param {string} 입력 문자열
 * @returns 문자열 입력 여부
 */
function hasText(value) {
    if (value === undefined || value.length === 0) {
        return false;
    }
    return true;
}

/**
 * 아이디(6~8자) 사용 가능 여부
 * @param {string} 입력 아이디
 * @returns 아이디 사용 가능 여부
 */
function isId(value) {
    const regExp = /^[a-zA-Z]+[0-9a-zA-Z]{5,7}$/g;
    return regExp.test(value);
}

/**
 * 이메일 사용 가능 여부
 * @param {string} 입력 이메일
 * @returns 이메일 사용 가능 여부
 */
function isEmail(value) {
    var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    return regExp.test(value);
}

/**
 * 숫자 입력 여부
 * @param {string} 입력 문자열
 * @returns 숫자 여부
 */
function isNumber(value) {
    let regExp = /^[0-9]*$/;
    return regExp.test(value);
}

/**
 * 한글 이름 입력 여부
 * @param {string} 입력 문자열
 * @returns 이름 입력 여부
 */
function isName(value) {
    let regExp = /^[가-힣]+$/;
    if (!regExp.test(value)) {
        return false;
    } else if (value.length < 2 || value.length > 10) {
        return false;
    }
    return true;
}