package com.yss.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yss.dto.wishListDTO;
import com.yss.mapper.WishlistMapper;
import com.yss.mybatis.support.MapperContainer;

public class WishlistServiceImpl implements WishlistService {

    // MapperContainer.get() 으로 호출
    private WishlistMapper mapper = MapperContainer.get(WishlistMapper.class);

    @Override
    public List<wishListDTO> listWishlist(Long memberId) throws Exception {
        List<wishListDTO> list = null;
        try {
            list = mapper.selectWishlistList(memberId);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    @Override
    public int getWishlistCount(Long memberId) throws Exception {
        int count = 0;
        try {
            count = mapper.selectWishlistCount(memberId);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return count;
    }

    @Override
    public String isWished(Long memberId, Long productId) throws Exception {
        String result = "N";
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("memberId", memberId);
            map.put("productId", productId);
            result = mapper.checkIsWished(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public void addWishlist(Long memberId, Long productId) throws Exception {
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("memberId", memberId);
            map.put("productId", productId);
            mapper.insertWishlist(map);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void removeWishlist(Long wishListId, Long memberId) throws Exception {
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("wishListId", wishListId);
            map.put("memberId", memberId);
            mapper.deleteWishlist(map);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void removeWishlistList(List<Long> wishListIds, Long memberId) throws Exception {
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("wishListIds", wishListIds);
            map.put("memberId", memberId);
            mapper.deleteWishlistList(map);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void clearWishlist(Long memberId) throws Exception {
        try {
            mapper.deleteAllWishlist(memberId);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}