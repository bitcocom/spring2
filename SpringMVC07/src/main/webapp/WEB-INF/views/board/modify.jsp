<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
 
<div class="container">
  <h2>Spring MVC</h2>
  <div class="panel panel-default">
    <div class="panel-heading">BOARD</div>
    <div class="panel-body">
      <form action="${cpath}/board/modify" method="post">
      <table class="table table-bordered">
         <tr>
          <td>번호</td>
          <td><input type="text" class="form-control" name="idx" readonly="readonly" value="${vo.idx}"/></td>
         </tr>
         <tr>
          <td>제목</td>
          <td><input type="text" class="form-control" name="title" value="<c:out value='${vo.title}'/>"/></td>          
         </tr>
         <tr>
          <td>내용</td>
          <td><textarea rows="10" class="form-control" name="content"><c:out value='${vo.content}'/></textarea> </td>
         </tr>
         <tr>
          <td>작성자</td>
          <td><input type="text" class="form-control" name="writer" readonly="readonly" value="${vo.writer}"/></td>
         </tr>
         <tr>
           <td colspan="2" style="text-align: center;">
              <c:if test="${!empty mvo && mvo.memID eq vo.memID}">
                <button type="submit" class="btn btn-sm btn-primary">수정</button>
                <button type="button" class="btn btn-sm btn-warning" onclick="location.href='${cpath}/board/remove?idx=${vo.idx}'">삭제</button> 
              </c:if>
              <c:if test="${empty mvo || mvo.memID ne vo.memID}">
                <button disabled="disabled" type="submit" class="btn btn-sm btn-primary">수정</button>
                <button disabled="disabled" type="button" class="btn btn-sm btn-warning" onclick="location.href='${cpath}/board/remove?idx=${vo.idx}'">삭제</button> 
              </c:if>
              <button type="button" class="btn btn-sm btn-info" onclick="location.href='${cpath}/board/list'">목록</button>
           </td>
         </tr>
      </table>
      </form>
    </div>
    <div class="panel-footer">스프2탄(답변형 게시판 만들기)</div>
  </div>
</div>

</body>
</html>