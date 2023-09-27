package com.icia.web.model;

import java.io.Serializable;
import java.util.Date;

public class KakaoPayReady2 implements Serializable{

   private static final long serialVersionUID = 1L;

   //카카오페이 페이지 결제 준비하기 - 응답(본문)부분
   private String tid;                     //결제 고유 번호, 20자
   private String next_redirect_app_url;      //요청한 클라이언트(Client)가 모바일 앱일 경우 카카오톡 결제 페이지 Redirect URL
   private String next_redirect_mobile_url;   //요청한 클라이언트가 모바일 웹일 경우   카카오톡 결제 페이지 Redirect URL
   private String next_redirect_pc_url;      //요청한 클라이언트가 PC 웹일 경우 카카오톡으로 결제 요청 메시지(TMS)를 보내기 위한 사용자 정보 입력 화면 Redirect URL
   private String android_app_scheme;         //카카오페이 결제 화면으로 이동하는 Android 앱 스킴(Scheme)
   private String ios_app_scheme;            //카카오페이 결제 화면으로 이동하는 iOS 앱 스킴
   private Date created_at;               //결제 준비 요청 시간
   
   
   public KakaoPayReady2()
   {
      tid = "";
      next_redirect_app_url = "";
      next_redirect_mobile_url = "";
      next_redirect_pc_url = "";
      android_app_scheme = "";
      ios_app_scheme = "";
      created_at = null;   
      
   }


   public String getTid() {
      return tid;
   }


   public void setTid(String tid) {
      this.tid = tid;
   }


   public String getNext_redirect_app_url() {
      return next_redirect_app_url;
   }


   public void setNext_redirect_app_url(String next_redirect_app_url) {
      this.next_redirect_app_url = next_redirect_app_url;
   }


   public String getNext_redirect_mobile_url() {
      return next_redirect_mobile_url;
   }


   public void setNext_redirect_mobile_url(String next_redirect_mobile_url) {
      this.next_redirect_mobile_url = next_redirect_mobile_url;
   }


   public String getNext_redirect_pc_url() {
      return next_redirect_pc_url;
   }


   public void setNext_redirect_pc_url(String next_redirect_pc_url) {
      this.next_redirect_pc_url = next_redirect_pc_url;
   }


   public String getAndroid_app_scheme() {
      return android_app_scheme;
   }


   public void setAndroid_app_scheme(String android_app_scheme) {
      this.android_app_scheme = android_app_scheme;
   }


   public String getIos_app_scheme() {
      return ios_app_scheme;
   }


   public void setIos_app_scheme(String ios_app_scheme) {
      this.ios_app_scheme = ios_app_scheme;
   }


   public Date getCreated_at() {
      return created_at;
   }


   public void setCreated_at(Date created_at) {
      this.created_at = created_at;
   }
   
}

