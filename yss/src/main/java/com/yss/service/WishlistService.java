package com.yss.service;

import java.util.List;
import com.yss.dto.wishListDTO;

public interface WishlistService {
    public int getWishlistCount(Long memberId) throws Exception;
    public void addWishlist(Long memberId, Long productId) throws Exception;
    public void removeWishlist(Long wishListId, Long memberId) throws Exception;
    public void removeWishlistList(List<Long> wishListIds, Long memberId) throws Exception;
    public void clearWishlist(Long memberId) throws Exception;
    public String isWished(Long memberId, Long productId) throws Exception;
    public List<wishListDTO> listWishlist(Long memberId) throws Exception;
}