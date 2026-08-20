package com.yss.mapper;

import java.util.List;
import java.util.Map;
import com.yss.dto.wishListDTO;

public interface WishlistMapper {
	public int insertWishlist(Map<String, Object> map) throws Exception;
    public int selectWishlistCount(Long memberId) throws Exception;
    public int deleteWishlist(Map<String, Object> map) throws Exception;
    public int deleteWishlistList(Map<String, Object> map) throws Exception;
    public int deleteAllWishlist(Long memberId) throws Exception;
    public List<wishListDTO> selectWishlistList(Long memberId) throws Exception;
    public String checkIsWished(Map<String, Object> map) throws Exception;
}