package com.smartmonkey.service.impl;

import com.smartmonkey.mapper.UserMapper;
import com.smartmonkey.model.User;
import com.smartmonkey.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;


    @Override
    public List<User> getUsers() {
        return userMapper.findAll();
    }
}
