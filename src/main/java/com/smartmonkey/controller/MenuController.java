package com.smartmonkey.controller;

import com.smartmonkey.model.SysMenu;
import com.smartmonkey.service.SysMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    SysMenuService sysMenuService;

    @GetMapping(value = "/list", produces = "application/json")
    public BaseResponse<List<SysMenu>> getMenuList() {
        // 需要根据用户来获取对应的权限
        return BaseResponse.success("", sysMenuService.getMenus());
    }
}
