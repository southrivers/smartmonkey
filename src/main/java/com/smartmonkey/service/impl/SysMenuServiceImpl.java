package com.smartmonkey.service.impl;

import com.smartmonkey.mapper.SysMenuMapper;
import com.smartmonkey.model.SysMenu;
import com.smartmonkey.service.SysMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysMenuServiceImpl implements SysMenuService {

    @Autowired
    SysMenuMapper sysMenuMapper;
    @Override
    public List<SysMenu> getMenus() {
        return sysMenuMapper.getMenuList();
    }
}
