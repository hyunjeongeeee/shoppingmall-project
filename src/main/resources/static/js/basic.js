//// slide out search
var sliBtn = '.search-btn',
    sliCont = '.search-slide',
    sliTxt = '.search-slide input[type=text]',
    sliDis = '.search-close',
    sliSpd = 400;

$(sliBtn).click(function(){
    $(sliCont).animate(
        {'width':'15.5625em'}, sliSpd
    );
    $(sliTxt).focus();
});
$(sliDis).click(function(){
    $(sliCont).animate(
        {'width':0}, sliSpd
    );
});