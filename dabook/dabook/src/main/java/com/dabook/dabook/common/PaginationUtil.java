package com.dabook.dabook.common;

import org.springframework.data.domain.Page;
import org.springframework.ui.Model;

public class PaginationUtil {
    public static void addPageAttributes(Model model, Page<?> page) {
        int totalPages = page.getTotalPages();
        int currentPage = page.getNumber() + 1;

        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage);
    }

    public static void addPageAttributesWithSize(Model model, Page<?> page, int size) {
        addPageAttributes(model, page);
        model.addAttribute("size", size);
    }
}
