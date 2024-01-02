// 전역 변수로 선언
const reContBox = $('textarea[name="reCont"]');
const reBox = $('.re-div');
const reCreateBtn = $('button[name="reCreateBtn"]');

async function sendQnaRe() {

    const reCont = reContBox.val();
    const qnaCode = reBox.attr('value');

    try {
        const response = await $.ajax({
            url: "/grrreung/itemqna/qna-re",
            method: "GET",
            data: {
                reCont: reCont,
                qnaCode: qnaCode
            }
        });

        // 등록버튼 수정으로 변경
        reCreateBtn.text('수정');
        reCreateBtn.attr('onclick', 'changeReadOnly()');

        // 삭제버튼 생성
        const updateBtn = document.createElement('button');
        updateBtn.textContent = '삭제';



        // 리드온리로 변경
        reBox.append(updateBtn);
        // reContBox.textContent = data.reCont;
        reContBox.val(`${response.reCont}\n${response.reDate}`);
        reContBox.prop('readonly',true);
        reContBox.addClass('qna-re-style');
        // getReCont(response);





        // 받은 데이터를 사용하여 업데이트할 요소 생성
        // const pTag = document.createElement('p');
        // pTag.textContent = response.reCont // 예시: 서버에서 'Success'를 전달하면 'Success'가 출력되도록 변경
        //
        // // 기존 요소에 추가
        // reBox.append(pTag);

        // 원하는 추가적인 처리 작업 수행 가능

    } catch (error) {
        console.error("실패", error);
    }
}

function getReCont(data){


}

function changeReadOnly(){
    reContBox.prop('readonly',false);
    reContBox.removeClass('qna-re-style');
    reCreateBtn.attr('onclick', 'updateQnaRe()');
}

function updateQnaRe(){
    // try {
    //     const response = await $.ajax({
    //         url: "/grrreung/itemqna/qna-re",
    //         method: "GET",
    //         data: {
    //             reCont: reCont,
    //             qnaCode: qnaCode
    //         }
    //     });
    //
    //
    // } catch (error) {
    //     console.error("실패", error);
    // }
}