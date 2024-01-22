package com.dabook.dabook.controller;

import com.dabook.dabook.dto.AddressDTO;
import com.dabook.dabook.service.AddressService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class AddressController {

    private final AddressService addressService;

    // 주소록 페이지 로드
    @GetMapping("/dabook/mypage/address")
    public String address(Model model, HttpSession session) throws JsonProcessingException {
        String userId = (String) session.getAttribute("userId");
        Long no = addressService.userNo(userId);
        session.setAttribute("userNo", no);


        List<AddressDTO> addrDto = addressService.addressList(no);

        ObjectMapper objectMapper = new ObjectMapper();
        String addr = objectMapper.writeValueAsString(addrDto);

        model.addAttribute("addr", addr);   // script
        model.addAttribute("no", no);   // script
        model.addAttribute("address", addrDto); // html

        return "main/address";
    }

    // 주소록 checked 삭제
    @DeleteMapping("/address/chkDel")
    public ResponseEntity<String> chkDel(@RequestBody Map<String, List<Integer>> delList){
        List<Integer> list = (delList.get("data"));
        List<Long> noList =  list.stream()
                .map(Long::valueOf)
                .toList();

        boolean isChkDel = addressService.chkAddrDel(noList);

        if (isChkDel) {
            return new ResponseEntity<>("삭제 성공", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 주소록 데이터
    @GetMapping("/address/data")
    @ResponseBody
    public List<AddressDTO> addrData(HttpSession session){
        Long no = (Long)session.getAttribute("userNo");
        return addressService.addressList(no);
    }

    // 한개 주소 삭제
    @DeleteMapping("/addressDel/{addressNo}")
    public ResponseEntity<String> addrDel(@PathVariable("addressNo") String addressNo){
        Long no = Long.parseLong(addressNo);
        boolean isDelete = addressService.addrDel(no);

        if (isDelete){
            return new ResponseEntity<>("삭제 성공", HttpStatus.OK);
        } else{
            return new ResponseEntity<>("삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 주소 추가
    @PostMapping("/address/add")
    public ResponseEntity<String> addrAdd(@RequestBody AddressDTO addrData, HttpSession session){

        Long no = (Long) session.getAttribute("userNo");
        String zipcode = addrData.getZipcode();
        String address = addrData.getAddress();
        String detail = addrData.getAddressDetail();

        boolean isAdd = addressService.addrAdd(no, zipcode, address, detail);

        if(isAdd){
            return new ResponseEntity<>("저장 성공", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("저장 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // userNo session에 저장
    @PostMapping("/address/modiNo")
    @ResponseBody
    public String modiNo(@RequestParam("no") String no, HttpSession session) {
        session.setAttribute("modiAddr", no);
        return no;
    }

    // 주소 추가
    @PostMapping("/address/modi")
    public ResponseEntity<String> addrModi(@RequestBody AddressDTO addrData, HttpSession session){
        String modiAddr = (String) session.getAttribute("modiAddr");
        Long no = Long.parseLong(modiAddr);

        addrData.setUserNo(no);
        String zipcode = addrData.getZipcode();
        String address = addrData.getAddress();
        String detail = addrData.getAddressDetail();

        boolean isModi = addressService.addrModi(no, zipcode, address, detail);

        if(isModi){
            return new ResponseEntity<>("수정 성공", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("수정 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


}
