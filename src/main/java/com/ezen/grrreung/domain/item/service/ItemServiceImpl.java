package com.ezen.grrreung.domain.item.service;

import com.ezen.grrreung.domain.cart.dto.Cart;
import com.ezen.grrreung.domain.item.dto.Category;
import com.ezen.grrreung.domain.item.dto.Item;
import com.ezen.grrreung.domain.item.dto.ItemImg;
import com.ezen.grrreung.domain.item.mapper.ItemMapper;
import com.ezen.grrreung.web.common.RequestParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ItemServiceImpl implements ItemService {

    private final ItemMapper itemMapper;

    @Autowired
    public ItemServiceImpl(ItemMapper itemMapper) {
        this.itemMapper = itemMapper;
    }

    @Override
    public List<Item> allItems() {
        return itemMapper.findAllItems();
    }

    @Override
    public List<Item> findByCate(RequestParams params) {
        return itemMapper.findByCategory(params);
    }


    @Override
    public Item findByItemId(int itemId) {
        return itemMapper.findByItemId(itemId);
    }

    @Override
    public String showThumbnail(int itemId) {
        return itemMapper.findThumbnail(itemId);
    }

    @Override
    public List<Map<String, Object>> showImageSlide(int itemId) {
        return itemMapper.findItemImages(itemId);
    }

    @Override
    public List<Map<String, Object>> showDescriptionImages(int itemId) {
        return itemMapper.findDescriptionImages(itemId);
    }

    @Override
    public List<Category> categoryAllList() {
        return itemMapper.findCateAll();
    }

    @Override
    public List<Category> showCateName(String cateTop) {
        return itemMapper.findCateName(cateTop);
    }

    @Override
    public List<Item> searchItem(RequestParams params) {
        return itemMapper.findByParams(params);
    }

    @Override
    public int countBySearchValue(RequestParams params) {
        return itemMapper.countByParams(params);
    }

//--------------------------------------------------------------------------------------------------------

    @Override
    public void registerItem(Item item) {
        itemMapper.createItem(item);
    }

    @Override
    public void uploadItemImg(ItemImg itemImg) {
          itemMapper.insertItemImg(itemImg);
    }

    @Override
    public int itemIdSequence() {
        return itemMapper.selectNextItemImgId();
    }


    @Override
    public Map<String, Object> updateInfo(int itemId) {
        return itemMapper.updateItemInfo(itemId);
    }

    @Override
    public Category getCateByItemId(int itemId) {
        return itemMapper.getCateByItemId(itemId);
    }


}