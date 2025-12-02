package com.smartmonkey.controller;

import lombok.Data;

import java.io.Serializable;

@Data
public class BaseResponse<T> implements Serializable {

    private String msg;

    private String code;

    private T data;

    public BaseResponse(String msg, String code, T data) {
        this.msg = msg;
        this.code = code;
        this.data = data;
    }

    /**
     * 泛型方法在声明的时候需要三个类类型字段，在使用的时候跟在“.”后面
     * @param msg
     * @param data
     * @return
     * @param <T>
     */
    public static <T> BaseResponse<T> success(String msg, T data) {
        return new BaseResponse<T>(msg, "200", data);
    }
}
