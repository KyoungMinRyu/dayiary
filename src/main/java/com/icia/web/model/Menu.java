package com.icia.web.model;

import java.io.Serializable;

public class Menu implements Serializable {

   private static final long serialVersionUID = 1L;

   private String menuSeq, rSeq, menuName, menuPrice, menuContent;

   private MenuFile menuFileList;
   // private List<Menu> menuList;
   private String fileName; // 메뉴사진 1장 받아온거 파일네임 저장용

   public Menu() {
      menuSeq = "";
      rSeq = "";
      menuName = "";
      menuPrice = "";
      menuContent = "";
      fileName = "";
      menuFileList = null;
      // menuList = null;
   }

   public String getFileName() {
      return fileName;
   }

   public MenuFile getMenuFileList() {
      return menuFileList;
   }

   public void setMenuFileList(MenuFile menuFileList) {
      this.menuFileList = menuFileList;
   }

   public void setFileName(String fileName) {
      this.fileName = fileName;
   }

   public String getMenuSeq() {
      return menuSeq;
   }

   public void setMenuSeq(String menuSeq) {
      this.menuSeq = menuSeq;
   }

   public String getrSeq() {
      return rSeq;
   }

   public void setrSeq(String rSeq) {
      this.rSeq = rSeq;
   }

   public String getMenuName() {
      return menuName;
   }

   public void setMenuName(String menuName) {
      this.menuName = menuName;
   }

   public String getMenuPrice() {
      return menuPrice;
   }

   public void setMenuPrice(String menuPrice) {
      this.menuPrice = menuPrice;
   }

   public String getMenuContent() {
      return menuContent;
   }

   public void setMenuContent(String menuContent) {
      this.menuContent = menuContent;
   }

}