package com.icia.web.model;

import java.io.Serializable;

public class MenuFile implements Serializable
{

   private static final long serialVersionUID = 1L;

   private short fileSeq;
   private String menuSeq,
               fileName;
   
   public MenuFile()
   {
      fileSeq = 0;
      menuSeq = "";
      fileName = "";
      
   }

   public short getFileSeq() {
      return fileSeq;
   }

   public void setFileSeq(short fileSeq) {
      this.fileSeq = fileSeq;
   }

   public String getMenuSeq() {
      return menuSeq;
   }

   public void setMenuSeq(String menuSeq) {
      this.menuSeq = menuSeq;
   }

   public String getFileName() {
      return fileName;
   }

   public void setFileName(String fileName) {
      this.fileName = fileName;
   }

}