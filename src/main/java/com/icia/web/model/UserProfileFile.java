package com.icia.web.model;

import java.io.Serializable;

public class UserProfileFile implements Serializable
{

   private static final long serialVersionUID = 1L;
   
   private String userId;
   private String fileName;
   
   
   public UserProfileFile()
   {
      userId = "";
      fileName = "";
   }


   public String getUserId()
   {
      return userId;
   }


   public void setUserId(String userId)
   {
      this.userId = userId;
   }


   public String getFileName()
   {
      return fileName;
   }


   public void setFileName(String fileName) 
   {
      this.fileName = fileName;
   }
   
}