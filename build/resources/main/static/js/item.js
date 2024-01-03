
let totalData; //총 데이터 수
let dataPerPage=5; //한 페이지에 나타낼 글 수
let pageCount = 5; //페이징에 나타낼 페이지 수
let globalCurrentPage=1; //현재 페이지
let dataList; //표시하려하는 데이터 리스트
let itemId = $("#itemId").text();

$(document).ready(function() {
    var slider = $("#slider");
    var thumb = $("#thumb");
    var slidesPerPage = 5; //globaly define number of elements per page
    var syncedSecondary = true;
    slider.owlCarousel({
        items: 1,
        slideSpeed: 2000,
        nav: false,
        autoplay: false, 
        dots: false,
        loop: true,
        responsiveRefreshRate: 200
    }).on('changed.owl.carousel', syncPosition);
    thumb
        .on('initialized.owl.carousel', function() {
            thumb.find(".owl-item").eq(0).addClass("current");
        })
        .owlCarousel({
            items: slidesPerPage,
            dots: false,
            nav: true,
            item: 4,
            smartSpeed: 200,
            slideSpeed: 500,
            slideBy: slidesPerPage, 
            navText: ['<svg width="18px" height="18px" viewBox="0 0 11 20"><path style="fill:none;stroke-width: 1px;stroke: #000;" d="M9.554,1.001l-8.607,8.607l8.607,8.606"/></svg>', '<svg width="25px" height="25px" viewBox="0 0 11 20" version="1.1"><path style="fill:none;stroke-width: 1px;stroke: #000;" d="M1.054,18.214l8.606,-8.606l-8.606,-8.607"/></svg>'],
            responsiveRefreshRate: 100
        }).on('changed.owl.carousel', syncPosition2);
    function syncPosition(el) {
        var count = el.item.count - 1;
        var current = Math.round(el.item.index - (el.item.count / 2) - .5);
        if (current < 0) {
            current = count;
        }
        if (current > count) {
            current = 0;
        }
        thumb
            .find(".owl-item")
            .removeClass("current")
            .eq(current)
            .addClass("current");
        var onscreen = thumb.find('.owl-item.active').length - 1;
        var start = thumb.find('.owl-item.active').first().index();
        var end = thumb.find('.owl-item.active').last().index();
        if (current > end) {
            thumb.data('owl.carousel').to(current, 100, true);
        }
        if (current < start) {
            thumb.data('owl.carousel').to(current - onscreen, 100, true);
        }
    }
    function syncPosition2(el) {
        if (syncedSecondary) {
            var number = el.item.index;
            slider.data('owl.carousel').to(number, 100, true);
        }
    }

    thumb.on("click", ".owl-item", function(e) {
        e.preventDefault();
        var number = $(this).index();
        slider.data('owl.carousel').to(number, 300, true);
    });


    // 수량 (+ , -)  조절
    $(".qtyminus").on("click", function() {
        var now = $(".qty").val();
        if ($.isNumeric(now) && parseInt(now) > 0) {
            now--;
            $(".qty").val(now).trigger("input");
        }
    });

    $(".qtyplus").on("click", function() {
        var now = $(".qty").val();
        if ($.isNumeric(now)) {
            $(".qty").val(parseInt(now) + 1).trigger("input");
        }
    });

    $(".qty").on("input", function() {
        var quantity = parseInt($(this).val()) || 0; // 수량
        var itemPrice = parseInt($(".totalAmount").val()) || 0; // 상품 가격

        // 계산된 총 가격을 표시할 곳
        var totalAmountPrint = $(".totalAmountPrint");

        var totalAmount = quantity * itemPrice;

        // 총 가격을 포맷팅하여 표시
        totalAmountPrint.text(new Intl.NumberFormat().format(totalAmount) + "원");
    });

// **************************************************************************************
 // 상세정보 <-----> 리뷰 탭 이동
    // Tab Menu
        let descTab = $('#desc_tab');
        let revTab = $('#review-tab');

        descTab.click(function () {
            descTab.addClass('active');
            revTab.removeClass('active');
            $('#description').addClass('active show');
            $('#review').removeClass('active show');
        });

        revTab.click(function () {
            descTab.removeClass('active');
            revTab.addClass('active');
            $('#description').removeClass('active show');
            $('#review').addClass('active show');
        });



// **************************************************************************************

        // dataPerPage = $("#dataPerPage").val();
        dataPerPage = 5;
        console.log("아이템 아이디: "+ itemId);
        console.log("데이터 개수 선택: "+ dataPerPage);

        $.ajax({ // ajax로 데이터 가져오기
            method: "GET",
            url: "/grrreung/itemrev/all-reviews?itemId="+itemId,
            contentType : "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "json",
            success: function (data) {
                // console.log("ajax데이터 확인: " + data);
                for(var i = 0; i<data.length; i++){
                    console.log("글번호: " + data[i].REV_CODE
                        + " | 제목 : "+ data[i].REV_TITLE
                        + " | 작성자 : " + data[i].MEMBER_ID
                        + " | 등록일 : "+ data[i].REV_DATE
                        + " [ITEM ID : "+ data[i].ITEM_ID + "]");
                }

                //데이터 대입
                dataList = data;
                //totalData(총 데이터 수) 구하기
                totalData = dataList.length;
                //글 목록 표시 호출 (테이블 생성)
                displayData(1, dataPerPage);
                //페이징 표시 호출
                paging(totalData, dataPerPage, pageCount, 1);
            },
            error : function(request, status, error){
                console.log("code:"+request.status+"\n"+"error:"+error);
            }
        });



//현재 페이지(currentPage)와 페이지당 글 개수(dataPerPage) 반영
    function displayData(currentPage, dataPerPage) {

        let chartHtml = "";

//Number로 변환하지 않으면 아래에서 +를 할 경우 스트링 결합이 되어버림..
        currentPage = Number(currentPage);
        dataPerPage = Number(dataPerPage);

        let maxpnum=(currentPage - 1) * dataPerPage + dataPerPage; ///추가
        if(maxpnum>totalData){maxpnum=totalData;} //추가

        for (var i = (currentPage - 1) * dataPerPage; i < maxpnum && i < dataList.length; i++) {

            chartHtml +=
                "<tr><td>" +
                dataList[i].REV_CODE +
                "</td><td class='rev_title'>" +
                dataList[i].REV_TITLE  +
                "</td><td>" +
                dataList[i].MEMBER_ID +
                "</td><td>" +
                dataList[i].REV_DATE +
                "</td></tr>" +
                "<tr class='rev_cont_wrap'><td colspan='4' class='rev_cont toggle-hide'><p>" +
                dataList[i].REV_CONT +
                "</p></td></tr>";
        } //dataList는 임의의 데이터임.. 각 소스에 맞게 변수를 넣어주면 됨...
        $(".review-board").html(chartHtml);
    }
    function paging(totalData, dataPerPage, pageCount, currentPage) {
        console.log("현재페이지 : " + currentPage);

        totalPage = Math.ceil(totalData / dataPerPage); //총 페이지 수

        if(totalPage<pageCount){
            pageCount=totalPage;
        }

        let pageGroup = Math.ceil(currentPage / pageCount); // 페이지 그룹
        let last = pageGroup * pageCount; //화면에 보여질 마지막 페이지 번호

        if (last > totalPage) {
            last = totalPage;
        }

        let first = last - (pageCount - 1); //화면에 보여질 첫번째 페이지 번호
        let next = last + 1;
        let prev = first - 1;

        let pageHtml = "";

        if (prev > 0) {
            pageHtml += "<li class='page-item'><a href='#' class='page-link' id='prev'>&laquo;</a></li>";
        }

        //페이징 번호 표시
        for (var i = first; i <= last; i++) {
            if (currentPage == i) {
                pageHtml +=
                    "<li class='page-item'><a href='#' class='page-link'>" + i + "</a></li>";
            } else {
                pageHtml += "<li class='page-item'><a class='page-link'>" + i + "</a></li>";
            }
        }

        if (last < totalPage) {
            pageHtml += "<li class='page-item'><a class='page-link' id='next'>&rsaquo;</a></li>";
        }

        $(".pagination").html(pageHtml);

        // let displayCount = "";
        // displayCount = "현재 1 - " + totalPage + " 페이지 / " + totalData + "건";
        // $("#displayCount").text(displayCount);


        //페이징 번호 클릭 이벤트
        $(".pagination li a").click(function () {
            let $id = $(this).attr("id");
            selectedPage = $(this).text();

            if ($id == "next") selectedPage = next;
            if ($id == "prev") selectedPage = prev;

            //전역변수에 선택한 페이지 번호를 담는다...
            globalCurrentPage = selectedPage;
            //페이징 표시 재호출
            paging(totalData, dataPerPage, pageCount, selectedPage);
            //글 목록 표시 재호출
            displayData(selectedPage, dataPerPage);
        });

    }

    // $("#dataPerPage").change(function () {
    //     dataPerPage = $("#dataPerPage").val();
    //     //전역 변수에 담긴 globalCurrent 값을 이용하여 페이지 이동없이 글 표시개수 변경
    //     paging(totalData, dataPerPage, pageCount, globalCurrentPage);
    //     displayData(globalCurrentPage, dataPerPage);
    // });

});





// 리뷰 내용 페이지 안에서 보여주기 (페이지 이동하지 않고)
// 동적으로 생성한 요소 => document.on
$(document).on("click", ".rev_title", function () {
    // console.log("리뷰제목클릭");
    $(this).closest('tr').next().find('.rev_cont').slideToggle(300);
    $(this).closest('tr').next().find('.rev_cont').toggleClass('toggle-hide')
    $(".rev_title").not(this).closest('tr').next().find('.rev_cont').slideUp(300);
});

// 페이지 로드 시 rev_cont를 숨김



