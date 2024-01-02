
    const mainCate = document.querySelector(".mainCategory");
    const subCategory = document.querySelector(".subCategory");

    // 메인 카테고리 select box에 change 이벤트 추가
    mainCate.addEventListener("change", selectCategory);


    // db에서 불러온 서브 카테고리 화면에 추가해주기
    // option 동적 생성
   async function selectCategory(event){
       subCategory.innerHTML = "";

       let array  = await categoryRequest();

        for (category  of  array) {
            // console.log(category.cateName);
            const option = document.createElement('option');
            option.value = category.cateCode;
            option.textContent = category.cateName;
            subCategory.appendChild(option);
        }

       // subCategory.value.innerHTML = `${category.cateName}`;
       //  array.forEach(category => {
       //     console.log(category.cateName);
       // });
    }

    // 상세 카테고리이름 불러오기
   function categoryRequest() {
        const category = mainCate.options[mainCate.selectedIndex].value;
        const url =`/grrreung/sub-category?category=${category}`;
        return fetch(url)
            .then((response) => {
                return response.json();
            });
   }





