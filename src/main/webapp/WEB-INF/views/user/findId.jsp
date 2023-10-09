<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page isELIgnored="false" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/include/head.jsp" %>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');

    *{
        box-sizing: border-box;
        outline: none;
    }

    body{
        font-family: 'Noto Sans KR', sans-serif;
        font-size:16px;
        background-color: white;
        line-height: 1.5em;
        color : #222;
        margin: 0;
    }
    
    b {
        color: #black;
    }

    a{
        text-decoration: none;
        color: #222;
    }

    p{
        margin: 1px;
        color: #59689b;
        font-size: 12px;
    }
    h2 
   {
      color: black;
   }
    h3 
   {
      color: #59689b;
   }

    .member {
        width: 400px;
        margin: auto;
        padding: 0 20px;
        margin-bottom: 20px;
        margin-top : 50px;
    }

    .member .logo {
        margin : 20px auto;
        width: 130px;
        height: 100px;
    }

    .member .field {
        margin : 5px 0;
    }

    .member b {
        display: block;
        margin-bottom: 5px;
    }

    .member input:not(input[type=radio]), 
    .member select {
        
        padding: 15px;
        width: 100%;
    }

      .member input[type=button], .member input[type=submit] {
        background-color: #59689b;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
        color:#fff;
    }

    .member input:focus, .member select:focus {
        border: 1px solid #9dafeb;
    }

    @media (max-width:768px) {
        .member {
            width: 100%;
        }
    }
</style>
<script>

function closeWindow() 
{
    window.close();
}
</script>

 
</head>
<body>
<div style="display:flex; justify-content:space-around;"><img style="width: 250px; height: 100px;" class="logo" src="../resources/images/logo.gif"></div>
    <div class="member">
        <a href="/user/login"></a>
        <h2 style="text-align : center;">아이디 찾기가 완료되었습니다.</h2>
        <h3 style="text-align : center;">가입된 아이디가 총 1개 있습니다.</h3>
        <hr />
       <div class="field">
            <h3><% if (request.getAttribute("userId") != null) { %>
    <div style="text-align : center; font-size: 25px;">
        입력한 정보로 조회된 아이디는 <a style="text-decoration : underline; color : pink;"><%= request.getAttribute("userId") %></a> 입니다.
    </div>
<% } %></h3>
           
        </div>        

<% if (request.getAttribute("message") != null)
   {
%>
    <div class="alert alert-warning">     
        <%= request.getAttribute("message") %>
    </div>
<% } %>
  
</div>
      <br /><br /><br /><br /><br />  
     <input type="button" value="로그인 페이지로 돌아가기" id="btnFindId" style="background-color: #59689b; width: 100%; height: 50px; color:white;" onclick="closeWindow()" />


   
</body>
</html>