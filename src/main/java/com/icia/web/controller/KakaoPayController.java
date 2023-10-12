package com.icia.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Delivery;
import com.icia.web.model.KakaoPayApprove;
import com.icia.web.model.KakaoPayApprove2;
import com.icia.web.model.KakaoPayOrder;
import com.icia.web.model.KakaoPayOrder2;
import com.icia.web.model.KakaoPayReady;
import com.icia.web.model.KakaoPayReady2;
import com.icia.web.model.OrderList;
import com.icia.web.model.Response;
import com.icia.web.service.GiftOrderService;
import com.icia.web.service.KakaoPayService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("kakaoPayController")

public class KakaoPayController {
   private static Logger logger = LoggerFactory.getLogger(KakaoPayController.class);

   @Autowired
   private KakaoPayService kakaoPayService;

   // 쿠키명
   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;

   @Autowired
   private KakaoPayService kakaoPayService2;

   @Autowired
   private GiftOrderService giftOrderService;

   @RequestMapping(value = "/kakao/payReady2", method = RequestMethod.POST)
   @ResponseBody
   public Response<Object> payReady2(HttpServletRequest request, HttpServletResponse response) {
      Response<Object> ajaxResponse = new Response<Object>();

      String orderId = StringUtil.uniqueValue();
      String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String itemCode = HttpUtil.get(request, "itemCode", "");
      String itemName = HttpUtil.get(request, "itemName", "");
      int quantity = HttpUtil.get(request, "quantity", (int) 0);
      int totalAmount = HttpUtil.get(request, "totalAmount", (int) 0);
      int taxFreeAmount = HttpUtil.get(request, "taxFreeAmount", (int) 0);
      int vatAmount = HttpUtil.get(request, "vatAmount", (int) 0);

      String giftFileName = HttpUtil.get(request, "giftFileName", "");
      String userName = HttpUtil.get(request, "userName", "");
      String userPh = HttpUtil.get(request, "userPh", "");
      String price = HttpUtil.get(request, "price", "");
      String productSeq = HttpUtil.get(request, "productSeq", "");
      String giftpContent = HttpUtil.get(request, "giftpContent", "");
      String receiveUserName = HttpUtil.get(request, "receiveUserName", "");
      String roadAddress = HttpUtil.get(request, "roadAddress", "");
      String detailAddress = HttpUtil.get(request, "detailAddress", "");
      String receiveUserPh = HttpUtil.get(request, "receiveUserPh", "");
      String deliveryMsg = HttpUtil.get(request, "deliveryMsg", "");

      // 카카오페이 DB저장용
      KakaoPayOrder2 kakaoPayOrder2 = new KakaoPayOrder2();

      kakaoPayOrder2.setPartnerOrderId(orderId);
      kakaoPayOrder2.setPartnerUserId(userId);
      kakaoPayOrder2.setItemCode(itemCode);
      kakaoPayOrder2.setItemName(itemName);
      kakaoPayOrder2.setQuantity(quantity);
      kakaoPayOrder2.setTotalAmount(totalAmount);
      kakaoPayOrder2.setTaxFreeAmount(taxFreeAmount);
      kakaoPayOrder2.setVatAmount(vatAmount);

      KakaoPayReady2 kakaoPayReady2 = kakaoPayService2.kakaoPayReady2(kakaoPayOrder2);
      // kakaoPayOrder객체에 담아서 Service단에서 카카오페이측에서 보낸 후 kakaoPayReady객체에 담는것

      if (kakaoPayReady2 != null) {
         logger.debug("[KakaoPayController] payReady2 : " + kakaoPayReady2);

         kakaoPayOrder2.settId(kakaoPayReady2.getTid());

         JsonObject json = new JsonObject();

         json.addProperty("orderId", orderId);
         json.addProperty("tId", kakaoPayReady2.getTid());
         json.addProperty("appUrl", kakaoPayReady2.getNext_redirect_app_url());
         json.addProperty("mobileUrl", kakaoPayReady2.getNext_redirect_mobile_url());
         json.addProperty("pcUrl", kakaoPayReady2.getNext_redirect_pc_url());

         json.addProperty("giftFileName", giftFileName);
         json.addProperty("userName", userName);
         json.addProperty("userPh", userPh);
         json.addProperty("price", price);
         json.addProperty("productSeq", productSeq);
         json.addProperty("giftpContent", giftpContent);
         json.addProperty("receiveUserName", receiveUserName);
         json.addProperty("roadAddress", roadAddress);
         json.addProperty("detailAddress", detailAddress);
         json.addProperty("receiveUserPh", receiveUserPh);
         json.addProperty("deliveryMsg", deliveryMsg);

         // OrderList DB저장용
         OrderList orderList = new OrderList();
         orderList.setProductSeq(itemCode);
         orderList.setUserId(userId);
         orderList.setStatus("W");

         if (giftOrderService.giftOrderListInsert(orderList) > 0) {

            json.addProperty("orderSeq", orderList.getOrderSeq());
            ajaxResponse.setResponse(0, "success", json);
         } else {
            ajaxResponse.setResponse(-1, "fail", null);
         }
      } else {
         ajaxResponse.setResponse(-1, "fail", null);
      }

      return ajaxResponse;
   }

   @RequestMapping(value = "/kakao/payPopUp2", method = RequestMethod.POST)
   public String payPopUp2(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
      String pcUrl = HttpUtil.get(request, "pcUrl", "");
      String orderId = HttpUtil.get(request, "orderId", "");
      String tId = HttpUtil.get(request, "tId", "");
      String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String orderSeq = HttpUtil.get(request, "orderSeq", "");

      String giftFileName = HttpUtil.get(request, "giftFileName1", "");
      String userName = HttpUtil.get(request, "userName1", "");
      String userPh = HttpUtil.get(request, "userPh1", "");
      String price = HttpUtil.get(request, "price1", "");
      String productSeq = HttpUtil.get(request, "productSeq1", "");
      String giftpContent = HttpUtil.get(request, "giftpContent1", "");
      String receiveUserName = HttpUtil.get(request, "receiveUserName1", "");
      String roadAddress = HttpUtil.get(request, "roadAddress1", "");
      String detailAddress = HttpUtil.get(request, "detailAddress1", "");
      String receiveUserPh = HttpUtil.get(request, "receiveUserPh1", "");
      String deliveryMsg = HttpUtil.get(request, "deliveryMsg1", "");

      String receiveAddress = (roadAddress + " " + detailAddress);

      model.addAttribute("pcUrl", pcUrl);
      model.addAttribute("orderId", orderId);
      model.addAttribute("tId", tId);
      model.addAttribute("userId", userId);
      model.addAttribute("orderSeq", orderSeq);

      model.addAttribute("giftFileName", giftFileName);
      model.addAttribute("userName", userName);
      model.addAttribute("userPh", userPh);
      model.addAttribute("price", price);
      model.addAttribute("productSeq", productSeq);
      model.addAttribute("giftpContent", giftpContent);
      model.addAttribute("receiveUserName", receiveUserName);
      model.addAttribute("receiveAddress", receiveAddress);
      model.addAttribute("receiveUserPh", receiveUserPh);
      model.addAttribute("deliveryMsg", deliveryMsg);

      return "/kakao/payPopUp2";
   }

   @RequestMapping(value = "/kakao/paySuccess2")
   public String paySuccess2(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
      String pgToken = HttpUtil.get(request, "pg_token", "");

      model.addAttribute("pgToken", pgToken);

      return "/kakao/paySuccess2";
   }

   @RequestMapping(value = "/kakao/payResult2")
   public String payResult2(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
      KakaoPayApprove2 kakaoPayApprove2 = null;

      String tId = HttpUtil.get(request, "tId", "");
      String orderId = HttpUtil.get(request, "orderId", "");
      String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String pgToken = HttpUtil.get(request, "pgToken", "");

      String orderSeq = HttpUtil.get(request, "orderSeq", "");
      String giftFileName = HttpUtil.get(request, "giftFileName", "");
      String userName = HttpUtil.get(request, "userName", "");
      String userPh = HttpUtil.get(request, "userPh", "");
      String price = HttpUtil.get(request, "price", "");
      String productSeq = HttpUtil.get(request, "productSeq", "");
      String giftpContent = HttpUtil.get(request, "giftpContent", "");
      String receiveUserName = HttpUtil.get(request, "receiveUserName", "");
      String receiveAddress = HttpUtil.get(request, "receiveAddress", "");
      String receiveUserPh = HttpUtil.get(request, "receiveUserPh", "");
      String deliveryMsg = HttpUtil.get(request, "deliveryMsg", "");

      KakaoPayOrder2 kakaoPayOrder2 = new KakaoPayOrder2();

      kakaoPayOrder2.setPartnerOrderId(orderId);
      kakaoPayOrder2.setPartnerUserId(userId);
      kakaoPayOrder2.settId(tId);
      kakaoPayOrder2.setPgToken(pgToken);

      kakaoPayApprove2 = kakaoPayService2.kakaoPayApprove2(kakaoPayOrder2);

      model.addAttribute("kakaoPayApprove2", kakaoPayApprove2);

      model.addAttribute("orderSeq", orderSeq);
      model.addAttribute("pgToken", pgToken);
      model.addAttribute("giftFileName", giftFileName);
      model.addAttribute("userName", userName);
      model.addAttribute("userPh", userPh);
      model.addAttribute("price", price);
      model.addAttribute("productSeq", productSeq);
      model.addAttribute("giftpContent", giftpContent);
      model.addAttribute("receiveUserName", receiveUserName);
      model.addAttribute("receiveAddress", receiveAddress);
      model.addAttribute("receiveUserPh", receiveUserPh);
      model.addAttribute("deliveryMsg", deliveryMsg);

      return "/kakao/payResult2";
   }

   // 결제 취소시
   @RequestMapping(value = "/kakao/payCancel2")
   public String payCancel2(HttpServletRequest request, HttpServletResponse response) {

      return "/kakao/payCancel2";
   }

   // 결제 실패시
   @RequestMapping(value = "/kakao/payFail2")
   public String payFail2(HttpServletRequest request, HttpServletResponse response) {
      return "/kakao/payFail2";
   }

   // 결제완료 페이지
   @RequestMapping(value = "/kakao/payComplete")
   public String payComplete(ModelMap model, HttpServletRequest request, HttpServletResponse response) {

      String pgToken = HttpUtil.get(request, "pgToken", "");
      String orderSeq = HttpUtil.get(request, "orderSeq", "");
      String giftFileName = HttpUtil.get(request, "giftFileName", "");
      String userName = HttpUtil.get(request, "userName", "");
      String userPh = HttpUtil.get(request, "userPh", "");
      String price = HttpUtil.get(request, "price", "");
      String productSeq = HttpUtil.get(request, "productSeq", "");
      int quantity = HttpUtil.get(request, "quantity", 0);
      int totalPrice = HttpUtil.get(request, "totalPrice", 0);
      String payMethod = HttpUtil.get(request, "payMethod", "");
      String giftpName = HttpUtil.get(request, "giftpName", "");
      String giftpContent = HttpUtil.get(request, "giftpContent", "");
      String receiveUserName = HttpUtil.get(request, "receiveUserName", "");
      String receiveAddress = HttpUtil.get(request, "receiveAddress", "");
      String receiveUserPh = HttpUtil.get(request, "receiveUserPh", "");
      String deliveryMsg = HttpUtil.get(request, "deliveryMsg", "");

      // 결제완료 후 PAY_LIST INSERT
      KakaoPayApprove2 giftPayList = new KakaoPayApprove2();

      giftPayList.setPartner_order_id(orderSeq);
      giftPayList.setPgToken(pgToken);
      giftPayList.setQuantity(quantity);
      giftPayList.setTotalPrice(totalPrice);
      giftPayList.setPayment_method_type(payMethod);

      if (!StringUtil.isEmpty(giftPayList)) {
         if (giftOrderService.giftPayListInsert(giftPayList) > 0) {

            // 결제 완료 후 ORDER_LIST STATUS 업데이트 (W->Y)
            if (orderSeq != null && orderSeq != "") {
               if (giftOrderService.giftOrderListUpdate(orderSeq) > 0) {
                  Delivery delivery = new Delivery();

                  delivery.setOrderAddress(receiveAddress);
                  delivery.setOrderSeq(orderSeq);
                  delivery.setOrderMsg(deliveryMsg);

                  if (!StringUtil.isEmpty(delivery)) {
                     // 결제 완료 후 DELIVERY INSERT
                     if (giftOrderService.deliveryInsert(delivery) > 0) {
                        model.addAttribute("orderSeq", orderSeq);
                        model.addAttribute("giftFileName", giftFileName);
                        model.addAttribute("userName", userName);
                        model.addAttribute("userPh", userPh);
                        model.addAttribute("price", price);
                        model.addAttribute("productSeq", productSeq);
                        model.addAttribute("quantity", quantity);
                        model.addAttribute("totalPrice", totalPrice);
                        model.addAttribute("payMethod", payMethod);
                        model.addAttribute("giftpName", giftpName);
                        model.addAttribute("giftpContent", giftpContent);
                        model.addAttribute("receiveUserName", receiveUserName);
                        model.addAttribute("receiveAddress", receiveAddress);
                        model.addAttribute("receiveUserPh", receiveUserPh);
                        model.addAttribute("deliveryMsg", deliveryMsg);

                        return "/kakao/payComplete";
                     } else {
                        return "/kakao/payFail2";
                     }

                  } else {
                     return "/kakao/payFail2";
                  }
               } else {
                  return "/kakao/payFail2";
               }

            } else {
               return "/kakao/payFail2";
            }

         } else {
            return "/kakao/payFail2";
         }
      } else {
         return "/kakao/payFail2";
      }

   }

   @RequestMapping(value = "/kakao/pay")
   public String pay(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
      // itemCode는 필수가 아니길래 삭제했음
      String itemName = HttpUtil.get(request, "restoName", ""); // reservationForm에 있는 레스토랑명을 itemName으로 가져옴
      int quantity = HttpUtil.get(request, "orderPerson", (int) 0); // reservationForm에 있는 예약인원수를 quantity로 가져옴
      int deposit = HttpUtil.get(request, "deposit", (int) 0); // reservationForm에 있는 예약금을 가져옴
      
      if(deposit == 0)
      {
         int totalAmount = HttpUtil.get(request, "totalAmount", (int) 0);
         model.addAttribute("totalAmount", totalAmount);
         
      }
      else if(deposit != 0)
      {
         int totalAmount = quantity * deposit; // 예약인원수 * 예약금을 totalAmount로 사용
         model.addAttribute("totalAmount", totalAmount);
      }
      
      
      String orderSeq = HttpUtil.get(request, "orderSeq", "");
      
      model.addAttribute("itemName", itemName);
      model.addAttribute("quantity", quantity);
      model.addAttribute("orderSeq", orderSeq);
      
      return "/kakao/pay";
   }

   @RequestMapping(value = "/kakao/payPopUp", method = RequestMethod.POST)
   public String payPopUp(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
      String pcUrl = HttpUtil.get(request, "pcUrl", "");
      String orderId = HttpUtil.get(request, "orderId", "");
      String tId = HttpUtil.get(request, "tId", "");
      String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

      model.addAttribute("pcUrl", pcUrl);
      model.addAttribute("orderId", orderId);
      model.addAttribute("tId", tId);
      model.addAttribute("userId", userId);

      return "/kakao/payPopUp";
   }

   @RequestMapping(value = "/kakao/payReady", method = RequestMethod.POST) // 카카오페이 사이트 결제 준비에서 필수에 O로 되있는것들을 먼저 준비해 보내
                                                         // 주기 위한 준비.
   @ResponseBody
   public Response<Object> payReady(HttpServletRequest request, HttpServletResponse response) {
      Response<Object> ajaxResponse = new Response<Object>();

      // String orderId = StringUtil.uniqueValue(); //partner_order_id를 UUID값으로 사용하기
      // 위해 UUID 값을 가지고 온 것.
      String orderId = HttpUtil.get(request, "orderId", ""); // orderList에 들어가는 orderSeq를 orderId로 사용
      String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME); // partner_user_id를 로그인하는 ID로 사용하기 위해 cookie의
                                                         // Id값을 가지고 온 것.
      String itemName = HttpUtil.get(request, "itemName", ""); // 상품명
      int quantity = HttpUtil.get(request, "quantity", (int) 0); // 상품수량
      int totalAmount = HttpUtil.get(request, "totalAmount", (int) 0); // 상품가격
      int taxFreeAmount = HttpUtil.get(request, "taxFreeAmount", (int) 0); // 상품비과세금액 (현재는 0원으로 보낼 예정)
      int vatAmount = HttpUtil.get(request, "vatAmount", (int) 0); // 상품부과세금액 (현재는 0원으로 보낼 예정)

      KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();

      kakaoPayOrder.setPartnerOrderId(orderId);
      kakaoPayOrder.setPartnerUserId(userId);
      kakaoPayOrder.setItemName(itemName);
      kakaoPayOrder.setQuantity(quantity);
      kakaoPayOrder.setTotalAmount(totalAmount);
      kakaoPayOrder.setTaxFreeAmount(taxFreeAmount);
      kakaoPayOrder.setVatAmount(vatAmount);

      KakaoPayReady kakaoPayReady = kakaoPayService.kakaoPayReady(kakaoPayOrder);

      if (kakaoPayReady != null) {
         logger.debug("[KakaoPayController] payReady : " + kakaoPayReady);

         kakaoPayOrder.settId(kakaoPayReady.getTid());

         JsonObject json = new JsonObject();

         json.addProperty("orderId", orderId);
         json.addProperty("tId", kakaoPayReady.getTid());
         json.addProperty("appUrl", kakaoPayReady.getNext_redirect_app_url()); // 전용 앱
         json.addProperty("mobileUrl", kakaoPayReady.getNext_redirect_mobile_url()); // 모바일 웹
         json.addProperty("pcUrl", kakaoPayReady.getNext_redirect_pc_url()); // pc 웹

         ajaxResponse.setResponse(0, "success", json);
      } else {
         ajaxResponse.setResponse(-1, "fail", null);
      }

      return ajaxResponse;
   }

   @RequestMapping(value = "/kakao/paySuccess")
   public String paySuccess(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
      String pgToken = HttpUtil.get(request, "pg_token", "");

      model.addAttribute("pgToken", pgToken);

      return "/kakao/paySuccess";
   }

   @RequestMapping(value = "/kakao/payResult")
   public String payResult(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
      KakaoPayApprove kakaoPayApprove = null;

      String tId = HttpUtil.get(request, "tId", "");
      String orderId = HttpUtil.get(request, "orderId", "");
      String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String pgToken = HttpUtil.get(request, "pgToken", "");

      KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();

      kakaoPayOrder.setPartnerOrderId(orderId);
      kakaoPayOrder.setPartnerUserId(userId);
      kakaoPayOrder.settId(tId);
      kakaoPayOrder.setPgToken(pgToken);

      kakaoPayApprove = kakaoPayService.kakaoPayApprove(kakaoPayOrder);

      model.addAttribute("kakaoPayApprove", kakaoPayApprove);

      return "/kakao/payResult";
   }

   @RequestMapping(value = "/kakao/payCancel")
   public String payCancel(HttpServletRequest request, HttpServletResponse response) {

      return "/kakao/payCancel";
   }

   @RequestMapping(value = "/kakao/payFail")
   public String payFail(HttpServletRequest request, HttpServletResponse response) {

      return "/kakao/payFail";
   }

}