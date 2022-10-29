<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<div class="card" style="min-height: 500px;max-height: 1000px;">
   <div class="row">
     <div class="col-lg-12">
       <div class="card-body">
        <c:if test="${empty mvo}">
         <h4 class="card-title">GUEST</h4>
         <p class="card-text">회원님 Welcome!</p>         
         <form action="${cpath}/login/loginProcess" method="post">
           <div class="form-group">
		    <label for="memID">아이디:</label>
		    <input type="text" class="form-control" name="memID">
		  </div>
		  <div class="form-group">
		    <label for="memPwd">비밀번호:</label>
		    <input type="password" class="form-control" name="memPwd">
		  </div>
		  <button type="submit" class="btn btn-primary form-control">로그인</button>
         </form>
         </c:if>
         <c:if test="${!empty mvo}">
         <h4 class="card-title">${mvo.memName}</h4>
         <p class="card-text">회원님 Welcome!</p>
		 <form action="${cpath}/login/logoutProcess" method="post">		  
		  <button type="submit" class="btn btn-primary form-control">로그아웃</button>
		 </form>
		</c:if>
       </div>
     </div>
   </div>    
   <div class="row">
     <div class="col-lg-12">
       <div class="card-body">
         <p class="card-text">MAP VIEW</p>
         <div class="input-group mb-3">
             <input type="text" class="form-control" id="address" placeholder="Search"/>
             <div class="input-group-append">
               <button type="button" class="btn btn-secondary" id="mapBtn">Go</button>             
             </div>         
         </div>
         <div id="map" style="width:100%;height:150px;"></div>
       </div>
     </div>
   </div>
</div>