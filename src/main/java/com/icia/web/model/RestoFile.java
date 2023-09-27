package com.icia.web.model;

import java.io.Serializable;

public class RestoFile implements Serializable
{
   private static final long serialVersionUID = 1L;

   private long fileSeq;
   private String rSeq,
               fileName;
   
   public RestoFile()
   {
      fileSeq = 0;
      rSeq = "";
      fileName = "";
   }

   public long getFileSeq() {
      return fileSeq;
   }

   public void setFileSeq(long fileSeq) {
      this.fileSeq = fileSeq;
   }

   public String getrSeq() {
      return rSeq;
   }

   public void setrSeq(String rSeq) {
      this.rSeq = rSeq;
   }

   public String getFileName() {
      return fileName;
   }

   public void setFileName(String fileName) {
      this.fileName = fileName;
   }
   
   
   
   
}