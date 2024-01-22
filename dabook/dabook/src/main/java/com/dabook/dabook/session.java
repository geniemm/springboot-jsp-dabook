package com.dabook.dabook;

import com.dabook.dabook.dto.CartDTO;

import java.util.ArrayList;
import java.util.List;

public interface session {
    List<CartDTO> items = new ArrayList<>();
    String modiAddr = "";
}
