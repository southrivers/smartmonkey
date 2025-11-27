package com.smartmonkey.mapper;

import com.smartmonkey.model.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {
    List<User> findAll();

    User findById(Long id);

    int insert(User user);
}
