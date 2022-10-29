<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="cpath" value="${pageContext.request.contextPath}"/>

<div class="card" style="min-height: 500px;max-height: 1000px;">
   <div class="card-body">
     <h4>BOOK SEARCH</h4>
     <div class="input-group mb-3">
             <input type="text" class="form-control" id="bookname" placeholder="Search"/>
             <div class="input-group-append">
               <a type="button" class="btn btn-secondary" id="search">Go</a>             
             </div>         
      </div>
      <div class="loading-progress" style="display: none;">
        <div class="spinner-border text-secondary" role="status">
          <span class="sr-only">Loading...</span>
        </div>      
      </div>
      <div id="bookList" style="overflow: scroll; height: 500px; padding: 10px">
         여기에 검색된 책 목록을 출력하세요.
      </div>
   </div>
</div>