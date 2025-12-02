package com.smartmonkey.mapper;

import com.smartmonkey.model.SysMenu;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SysMenuMapper {

    List<SysMenu> getMenuList();

    int updateSysMenu(SysMenu sysMenu);

    int insertSysMenu(SysMenu sysMenu);

    int deleteSysMenuById(@Param("menuId") Long id);
}
