$(document).ready(function () {
    // 초기화면 출력시 전체checked 속성 부여하기, 전체선택 check box도 포함
    $('#all_chk').prop('checked', true);
    $('[name="item_chk"]').prop('checked', true);
    calculateTotalPrice(); // 총 가격 계산 함수 호출


    // 합계 업데이트 함수
    function updateTotal() {
        var total = 0;
        var checkboxes = document.querySelectorAll('[name="item_chk"]:checked');
        checkboxes.forEach(function (checkbox) {
            var row = checkbox.closest('li');
            var amount = parseInt(row.querySelector('.number').value);
            var itemPrice = parseInt(row.querySelector('.itemPrice').value);
            total += amount * itemPrice;
        });

        // 총 결제 금액 업데이트
        calculateTotalPrice(total);
        var totalElement = document.querySelector('.total_price');
        totalElement.innerText = total.toLocaleString();
    }

    // 총 결제 금액
    function pay_total_func(){
        let amount_total = 0;

        $('.cart_list li').each(function() {
            let converse_unit;
            if($(this).find('[name="item_chk"]').prop("checked")){
                converse_unit = $(this).find('.price_amount').text().replace(/[^0-9]/g,"");
            }
            amount_total = amount_total + (parseInt(converse_unit) || 0);
        });

        //총 상품금액
        $('.cart_total_price').children().find(".item_price").text(amount_total.toLocaleString());

        // 총 배송비
        let total_delivery_price = 0;

        // 상품이 선택되있을 때 배송비 나오게
        let selectedItems = $('.cart_list li input[name="item_chk"]:checked');
        if (selectedItems.length > 0) {
            total_delivery_price = parseInt($('.cart_total_price').children().find('.delivery_price').text().replace(/[^0-9]/g, "") || 0);
        }

        // 삭제 버튼에 표시되는 선택된 상품 수 업데이트
        let total_price = amount_total + total_delivery_price;
        $('.cart_total_price').children().find('.total_price').text(total_price.toLocaleString());

        // 체크된 상품 수 업데이트
        let selectedItemsCount = $('.cart_list li input[name="item_chk"]:checked').length;
        $('.del_btn .num').text(selectedItemsCount);

    }

    // 체크박스 변경 시 총 결제 금액 업데이트
    $('.cart_list li input[name="item_chk"]').on('change', function() {
        pay_total_func();
    });

    // 페이지 로딩 시 초기 총 결제 금액 설정
    pay_total_func();


    // 전체 선택 체크박스
    document.getElementById('all_chk').addEventListener('change', function () {
        var checkboxes = document.querySelectorAll('[name="item_chk"]');
        checkboxes.forEach(function (checkbox) {
            checkbox.checked = this.checked;
        });
        // 업데이트 전에 선택된 상품들의 총 결제 금액을 계산
            updateTotal();

        // 전체 선택 시에만 배송비를 고려하여 다시 총 결제 금액을 업데이트
        pay_total_func();
    });


    // 체크박스 변경 시 총 결제 금액 업데이트 및 선택된 상품 수 업데이트
        document.getElementsByName('all_chk')[0].addEventListener('change', function () {
            /* 체크박스 체크/해제 */
            if($('[name="all_chk"]').prop("checked")){
                $('[name="item_chk"]').prop("checked", true);
            } else {
                $('[name="item_chk"]').prop("checked", false);
            }
            // updateTotal(); // 전체 선택 체크박스 변경 시 총 결제 금액 업데이트
            pay_total_func();
            updateSelectedCount(); // 선택된 상품 수 업데이트
        });


    // 개별 상품 체크박스 클릭 시
    document.querySelectorAll('[name="item_chk"]').forEach(function (checkbox) {
        checkbox.addEventListener('change', function () {

            updateTotal(); // 개별 체크박스 변경 시 총 결제 금액 업데이트
            updateSelectedCount(); // 선택된 상품 수 업데이트
        });
    });

    // 초기 페이지 로딩 시 기본 전체선택에 따른 삭제 수량 동적 업데이트
    $(document).ready(function () {
        if ($('[name="all_chk"]').prop("checked")) {
            $('[name="item_chk"]').prop("checked", true);
        }
        updateSelectedCount();
    });

    // 상품 선택 시 삭제 수량 동적 업데이트
    function updateSelectedCount() {
        var selectedCount = $('[name="item_chk"]:checked').length;
        $('.del_btn .num').text(selectedCount);
    }


    $(".minus_btn").on("click", function () {
        updateQuantity(-1, $(this));
        updateCheckboxState($(this));
        calculateTotalPrice(); // Update total price after clicking "-"
    });

    $(".plus_btn").on("click", function () {
        updateQuantity(1, $(this));
        updateCheckboxState($(this));
        calculateTotalPrice(); // Update total price after clicking "+"
    });

    $(".number").on("input", function () {
        calculateTotalPrice(); // Update total price when the quantity changes manually
    });
    function updateCheckboxState(button) {
        var $checkbox = button.closest("li").find('[name="item_chk"]');
        $checkbox.prop("checked", true);
        updateTotal();
    }
    // 체크박스 변경 시 총 결제 금액 업데이트
    document.querySelectorAll('[name="item_chk"]').forEach(function (checkbox) {
        checkbox.addEventListener('change', function () {
            calculateTotalPrice();
        });
    });


    function updateQuantity(change, button) {
        var $quantityInput = button.siblings(".number");
        var currentQuantity = parseInt($quantityInput.val()) || 0;
        var newQuantity = currentQuantity + change;

        if (newQuantity >= 0 && newQuantity <= 30) {
            $quantityInput.val(newQuantity).trigger("input");
        }
    }

    function calculateTotalPrice() {
        var totalAmount = 0;

        $(".cart_list li").each(function () {
            var $item = $(this);
            var $checkbox = $item.find('[name="item_chk"]');
            var isChecked = $checkbox.is(":checked");

            var quantity = parseInt($item.find(".number").val()) || 0;
            var itemPrice = parseInt($item.find(".itemPrice").val()) || 0;

            var itemTotalAmount = quantity * itemPrice;

            if (isChecked) {
                totalAmount += itemTotalAmount;
            }

            $item.find(".price_amount").text(new Intl.NumberFormat().format(itemTotalAmount) + "원");
        });

        var totalAmountPrint = $("#totalAmountPrint");
        totalAmountPrint.text(new Intl.NumberFormat().format(totalAmount) + "원");

        // Call your function to update the total price in the cart
        pay_total_func();
    }


    // 장바구니 수량 업데이트
    // const memberId = $("#memberId").text();
    // console.log("장바구니 멤버아이디: " + memberId);

    $(".cart-action-btn").click(function () {
        let cartId = $(this).siblings("#cartId").text();
        console.log("선택한 아이템의 카트아이디 : " + cartId);
        let action = $(this).hasClass("plus_btn") ? "plus" : "minus";

        // AJAX 요청을 통해 백엔드 컨트롤러에 데이터 전송
        $.ajax({
            type: "GET",
            url: "/grrreung/cart/amount-" + action,
            data: { cartId: cartId },
            success: function () {
                // 성공 시 페이지의 장바구니 수량 업데이트
                // updateCartAmount(itemId, action);
            },
            error: function (xhr, status, error) {
                console.error("장바구니 수량 업데이트 에러:", error);
            }
        });
    });

    // 페이지의 장바구니 수량 업데이트를 위한 함수
    function updateCartAmount(itemId, action) {
        var cartAmountInput = $("input.cart-amount[data-item-id='" + itemId + "']");
        var currentAmount = parseInt(cartAmountInput.val());

        if (action === "plus") {
            currentAmount++;
        } else if (action === "minus" && currentAmount > 1) {
            currentAmount--;
        }

        // 업데이트된 수량을 페이지에 반영
        cartAmountInput.val(currentAmount);
    }

});

// 체크된 상품 삭제
function selectDelete() {
    // 체크된 상품의 정보를 담을 배열
    var selectedItems = [];

    // 체크된 상품들의 체크박스를 선택
    var selectedCheckboxes = document.querySelectorAll('input[name="item_chk"]:checked');
    let param = ''
    // 각 체크된 상품에 대한 처리
    selectedCheckboxes.forEach(function (checkbox) {
        param += `itemId=${checkbox.value}&`;
    });


    // 추출된 상품 정보 확인 (개발자 도구의 콘솔에 출력)
    console.log(selectedItems);

    // 여기서 추출한 정보를 이용하여 장바구니 페이지로 이동 또는 처리할 로직 추가
    window.location.href = `/grrreung/cart/delete?${param}`;  // 예시: 장바구니 페이지로 이동
    }


function goToOrder() {

    // 체크된 상품들의 체크박스를 선택
    var selectedCheckboxes = document.querySelectorAll('input[name="item_chk"]:checked');

    if(selectedCheckboxes.length === 0 ){

        alert("주문하실 상품을 선택 해 주세요.")

    } else {

        let param = ''

        // 체크박스의 value(itemId) 가져와서 param에 담기
        selectedCheckboxes.forEach(function (checkbox) {
            param += `itemId=${checkbox.value}&`;
        });

        // 주문서 작성화면으로 get매핑
        window.location.href = `/grrreung/order/form?${param}`;

    }
}



























