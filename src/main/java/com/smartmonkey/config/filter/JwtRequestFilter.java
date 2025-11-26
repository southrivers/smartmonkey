package com.smartmonkey.config.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class JwtRequestFilter extends OncePerRequestFilter {
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        // TODO 这里去拦截请求并校验即可
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken("testuser", null, null);
        SecurityContextHolder.getContext().setAuthentication(authenticationToken);
        // 获取对应的token信息并解密
        filterChain.doFilter(request, response);
    }
}
