package com.ezen.grrreung.web.item.controller;

import com.ezen.grrreung.domain.item.dto.*;
import com.ezen.grrreung.domain.item.service.ItemService;
import com.ezen.grrreung.web.common.page.FileStore;
import com.ezen.grrreung.web.common.page.Pagination;
import com.ezen.grrreung.web.common.page.RequestParams;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@Controller
@RequestMapping("/grrreung")
@RequiredArgsConstructor
@Slf4j
public class ItemController {

    private final ItemService itemService;

    @Value("${file.dir}")
    private String location;

    private final FileStore fileStore;

    // 홈화면
    @RequestMapping("/")
    public String homeItemList(Model model){
        List<Item> list = itemService.allItems();
        model.addAttribute("item", list);
        return "/grrreung/index";
    }

    // shop 상품 전체목록 불러오기
    @GetMapping("/shop")
    public String allItemsList(Model model){
        List<Item> list = itemService.allItems();
        model.addAttribute("item", list);
        RequestParams params = new RequestParams();

        int totalElement = itemService.countByParams(params);
        log.info(" *** 검색 개수 : {} ", totalElement);

        Pagination pagination = new Pagination(params, totalElement);
        log.info(" *** 첫페이지 : {}",pagination.getStartPage());
        log.info(" *** 끝페이지 : {}",pagination.getEndPage());
        log.info(" ***** pagination : {}", pagination);
        model.addAttribute("pagination", pagination);

        return "/grrreung/sub/shop";
    }


    // 상품 검색
    @GetMapping("/search")
    public String searchList(@RequestParam(value="searchValue") String itemName, Model model) {
        RequestParams params = new RequestParams();
        String searchValue = itemName;
        params.setSearch(searchValue);
        log.info(" *** 넘겨받은 search값 : {}", searchValue);

        List<Item> searchList =  itemService.searchItem(params);
        model.addAttribute("item", searchList);
        log.info(" *** 검색 목록 : {}", searchList);

        int totalElement = itemService.countByParams(params);
        log.info(" *** 검색 개수 : {} ", totalElement);

        Pagination pagination = new Pagination(params, totalElement);
        log.info(" *** 첫페이지 : {}",pagination.getStartPage());
        log.info(" *** 끝페이지 : {}",pagination.getEndPage());
        log.info(" ***** pagination : {}", pagination);
        model.addAttribute("pagination", pagination);

        return "/grrreung/sub/shop";
    }


    // 아이템 아이디로 상품 한개 상세정보
    @RequestMapping("/shop/item/{itemId}")
    public String itemInfo(@PathVariable("itemId")int itemId, Model model){
        Item item = itemService.findByItemId(itemId);
        // 슬라이드 상품이미지 가져오기
        List<Map<String, Object>> imgFiles = itemService.showImageSlide(itemId);
        // 상품 정보 이미지 가져오기
        List<Map<String, Object>> itemDescription = itemService.showDescriptionImages(itemId);

        model.addAttribute("item", item);
        model.addAttribute("imgFiles", imgFiles);
        model.addAttribute("itemDescription", itemDescription);
        return "/grrreung/sub/item";
    }


    // 썸네일 이미지 1개 불러오기 => index, shop
    @GetMapping("/thumbnail/{itemId}")
    public ResponseEntity<Resource> thumbnailImage(String fileName, @PathVariable("itemId")int itemId, Model model) throws IOException {
        log.info("아이템 아이디:{}", itemId);

        String imgFileName = itemService.showThumbnail(itemId);
        log.info("파일명: {}", imgFileName);

        Path path = Paths.get(location + imgFileName);
        String contentType = Files.probeContentType(path);
        log.info("컨텐트타입 : {}",contentType);

		// 이미지 파일
		HttpHeaders headers = new HttpHeaders();
		headers.add(HttpHeaders.CONTENT_TYPE, contentType);
		Resource resource = new FileSystemResource(path);

		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}

    //  이미지 1개 불러오기 => 보여주기
    @GetMapping("/img/{imgName}")
    public ResponseEntity<Resource> imageRender(@PathVariable("imgName") String imgName, Model model) throws IOException {

        Path path = Paths.get(location + imgName);
		String contentType = Files.probeContentType(path);

		HttpHeaders headers = new HttpHeaders();
		headers.add(HttpHeaders.CONTENT_TYPE, contentType);
		Resource resource = new FileSystemResource(path);
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
    }

//=============================================================================================================

    // 이미지 슬라이드
    @GetMapping("/itemInfoImage/{itemId}")
    public ResponseEntity<Map<String, Object>> itemDescriptionImages(@PathVariable("itemId")int itemId, Model model) throws IOException {
        List<Map<String, Object>> itemDescription = itemService.showDescriptionImages(itemId); // 상품 상세정보 - 상품 상세정보 이미지

        String imageDescription = "";
        Resource resource = null;
        HttpHeaders headers = new HttpHeaders();
        Map<String, Object> result = new HashMap<>();

        for(Map<String, Object>  map : itemDescription) {
            imageDescription = (String) map.get("IMG_NAME");
            log.info("1)파일명 : {}", imageDescription);
            Path path = Paths.get(location + "/" + imageDescription);

            String contentType = Files.probeContentType(path);
            headers.add(HttpHeaders.CONTENT_TYPE, contentType);
            resource = new FileSystemResource(path);
        }
        return new ResponseEntity<Map<String, Object>>(result, headers, HttpStatus.OK);
    }
//=============================================================================================================


    // 카테고리별 상품 출력
    @GetMapping("/shop/{cateTop}")
    public String itemCate(@PathVariable("cateTop")String cateTop, Model model) {
        List<Item> item = itemService.findByCate(cateTop);
        model.addAttribute("item", item);
        return "/grrreung/sub/shop";
    }
// ===================================================================================================
    // 상위 카테고리 이름 DB에서 찾아오기
    @RequestMapping("/admin")
    public String searchCategory(Model model) {
        List<Category> cateList = itemService.categoryAllList();
        model.addAttribute("cateList", cateList);
//        log.info("{}", cateList);
        return "/grrreung/sub/admin-item";
    }

    // 상세 카테고리 불러오기
    @GetMapping("/sub-category")
    @ResponseBody
    public List<Category> searchDetailCategory(@RequestParam String category, Model model) {
        log.info("수신한 메인카테고리 : {}", category);
        List<Category> subCateList = itemService.showCateName(category);
        log.info("검색한 상세 카테고리 : {}", subCateList);
        return subCateList;
    }

//==============================================================================================

    // 관리자 권한으로 아이템 등록하기

    @PostMapping("/register-item")
    public String  registerItem(@ModelAttribute Item item, @RequestParam int cateCode, @ModelAttribute UploadForm uploadForm, RedirectAttributes redirectAttributes)
            throws IOException {
        log.info("수신정보:{}", item.toString());
        item.setCateCode(cateCode);
        itemService.registerItem(item);
        // 카테고리 선택한정보로 value값으로 카테고리 코드 cateCode 받아오기
//        log.info("업로드 파일: {}", uploadForm.getUploadfiles1());

        // 파일 저장************************************************************************
        // 썸네일
        List<UploadFile> uploadFiles1 = fileStore.storeFilesThumb(uploadForm.getUploadfiles1());
//        log.info("썸네일 파일명 : {}", uploadFiles1);
        // 상세정보
        List<UploadFile> uploadFiles2 = fileStore.storeFilesDescrip(uploadForm.getUploadfiles2());
//        log.info("상세정보 파일명 : {}", uploadFiles2);

        // 썸네일))) DB 테이블에 업로드 파일과 저장된 파일명 저장 후
        for(int i=0; i<uploadFiles1.size(); i++) {
            UploadFile uploadFile = uploadFiles1.get(i);
            ItemImg itemImg = new ItemImg();
            itemImg.setItemId(item.getItemId());
            itemImg.setImgName(uploadFile.getStoreFileName());
            itemImg.setOriImgName(uploadFile.getUploadFileName());

            // 마지막 파일에 대한 조건 추가
            if (i == uploadFiles1.size() - 1) {
                // 마지막 파일에 대한 특별한 처리를 수행
                itemImg.setRepImgYN("Y");
            } else {
                itemImg.setRepImgYN("N");
            }

            log.info("*********** 썸네일 파일정보 : {}", itemImg);
            itemService.uploadItemImg(itemImg);
        }

        // 상세정보))) DB 테이블에 업로드 파일과 저장된 파일명 저장 후
        for(UploadFile uploadFile : uploadFiles2) {
            ItemImg itemImg = new ItemImg(item.getItemId(), uploadFile.getStoreFileName(), uploadFile.getUploadFileName(), null);
            log.info("상세이미지 파일정보 : {}", uploadFile);
            itemService.uploadItemImg(itemImg);
        }

        return "redirect:/grrreung/admin";
    }


    @RequestMapping ("/update-item")
    public String registerItem(Model model) {
        List<Category> cateList = itemService.categoryAllList();
        model.addAttribute("cateList", cateList);


        Map<String, Object> map = itemService.updateInfo(1);
        model.addAttribute("item", map);

        return "/grrreung/sub/admin-item-update";

    }

    // 썸네일 사진 한장 가지고와서 대표사진 여부 테이블에 등록해주기
//    @PostMapping("/saveThumbnail")
//    @ResponseBody
//    public String saveThumbnail(@RequestParam String url) {
//        // 여기에서 DB에 썸네일 정보를 저장하는 로직을 수행
//        log.info("****************************************************");
//        log.info("Thumbnail ID: " + url + " saved to the database.");
//        log.info("****************************************************");
//
//        // 클라이언트에게 응답
//        return "redirect:/grrreung/admin";
//    }


//==============================================================================================

    // 회원 장바구니에 아이템 추가하기
    @RequestMapping("/my-cart")
    public String addItemToCart(){


        return "/grrreung/sub/cart";
    }



//    @GetMapping("/order")
//    public String orderSheet() {
//        return "/grrreung/sub/order-sheet";
//    }





}
