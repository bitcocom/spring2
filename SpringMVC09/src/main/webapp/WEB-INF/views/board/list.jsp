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
  <script type="text/javascript">
     $(document).ready(function(){
    	var result='${result}'; 
    	checkModal(result); 
    	 
    	$("#regBtn").click(function(){
    		location.href="${cpath}/board/register";
    	}); 
    	//페이지 번호 클릭시 이동 하기
    	var pageFrm=$("#pageFrm");
    	$(".paginate_button a").on("click", function(e){
    		e.preventDefault(); // a tag의 기능을 막는 부분
    		var page=$(this).attr("href"); // 페이지번호
    		pageFrm.find("#page").val(page);
    		pageFrm.submit(); // /sp08/board/list   		
    	});    	
    	// 상세보기 클릭시 이동 하기
    	$(".move").on("click", function(e){
    		e.preventDefault(); // a tag의 기능을 막는 부분
    		var idx=$(this).attr("href");
    		var tag="<input type='hidden' name='idx' value='"+idx+"'/>";
    		pageFrm.append(tag);
    		pageFrm.attr("action","${cpath}/board/get");
    		pageFrm.attr("method","get");
    		pageFrm.submit();
    	});
    	
     });
     function checkModal(result){
    	 if(result==''){
    		 return;
    	 }    	 
    	 if(parseInt(result)>0){
    		 // 새로운 다이얼로그 창 띄우기
    		 $(".modal-body").html("게시글 "+parseInt(result)+"번이 등록되었습니다.");    		 
    	 }
    	 $("#myModal").modal("show");
     }
     function goMsg(){
    	 alert("삭제된 게시물입니다."); // Modal창
     }
  </script>
</head>
<body>
 
<div class="container">
  <h2>Spring MVC</h2>
  <div class="panel panel-default">
    <div class="panel-heading">
        <c:if test="${empty mvo}">
	     <form class="form-inline" action="${cpath}/login/loginProcess" method="post">
		  <div class="form-group">
		    <label for="memID">ID:</label>
		    <input type="text" class="form-control" name="memID">
		  </div>
		  <div class="form-group">
		    <label for="memPwd">Password:</label>
		    <input type="password" class="form-control" name="memPwd">
		  </div>
		  <button type="submit" class="btn btn-default">로그인</button>
		 </form>
		</c:if>
		<c:if test="${!empty mvo}">
		 <form class="form-inline" action="${cpath}/login/logoutProcess" method="post">
		  <div class="form-group">
		    <label>${mvo.memName}님 방문을 환영합니다.</label>		    
		  </div>
		  <button type="submit" class="btn btn-default">로그아웃</button>
		 </form>
		</c:if>
    </div>
    <div class="panel-body">
      <table class="table table-bordered table-hover">
        <thead>
          <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
          </tr>
        </thead>
        <c:forEach var="vo" items="${list}">
          <tr>
            <td>${vo.idx}</td>           
            <td>
            <c:if test="${vo.boardLevel>0}">
              <c:forEach begin="1" end="${vo.boardLevel}">
                 <span style="padding-left: 10px"></span>
              </c:forEach>            
            </c:if>
            <c:if test="${vo.boardLevel>0}">
              <c:if test="${vo.boardAvailable==1}">
               <a class="move" href="${vo.idx}"><c:out value='[RE]${vo.title}'/></a>
              </c:if>
              <c:if test="${vo.boardAvailable==0}">
               <a href="javascript:goMsg()">[RE]삭제된 게시물입니다.</a>
              </c:if>
            </c:if>
            <c:if test="${vo.boardLevel==0}">
              <c:if test="${vo.boardAvailable==1}">
                <a class="move" href="${vo.idx}"><c:out value='${vo.title}'/></a>
              </c:if>
              <c:if test="${vo.boardAvailable==0}">
                <a href="javascript:goMsg()">삭제된 게시물입니다.</a>
              </c:if>
            </c:if>
            </td>
            <td>${vo.writer}</td>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.indate}"/></td>
            <td>${vo.count}</td>
          </tr>
        </c:forEach>
        <c:if test="${!empty mvo}"> 
        <tr>
          <td colspan="5">
            <button id="regBtn" class="btn btn-sm btn-primary pull-right">글쓰기</button>            
          </td>
        </tr>
        </c:if>
      </table>
      <!-- 검색메뉴 -->
       <div style="text-align: center;">
		<form class="form-inline" action="${cpath}/board/list" method="post">
		  <div class="form-group">	
		   <select name="type" class="form-control">
		      <option value="writer" ${pageMaker.cri.type=='writer' ? 'selected' : ''}>이름</option>
		      <option value="title" ${pageMaker.cri.type=='title' ? 'selected' : ''}>제목</option>
		      <option value="content" ${pageMaker.cri.type=='content' ? 'selected' : ''}>내용</option>
		   </select>
		  </div>
		  <div class="form-group">	
		    <input type="text" class="form-control" name="keyword" value="${pageMaker.cri.keyword}">
		  </div>
		  <button type="submit" class="btn btn-success">검색</button>
		</form>
	   </div>
      <!-- 페이징 START -->
      <div style="text-align: center">
	    <ul class="pagination">
      <!-- 이전처리 -->
      <c:if test="${pageMaker.prev}">
        <li class="paginate_button previous">
          <a href="${pageMaker.startPage-1}">◀</a>
        </li>
      </c:if>      
      <!-- 페이지번호 처리 -->
          <c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
	         <li class="paginate_button ${pageMaker.cri.page==pageNum ? 'active' : ''}"><a href="${pageNum}">${pageNum}</a></li>
		  </c:forEach>    
      <!-- 다음처리 -->
      <c:if test="${pageMaker.next}">
        <li class="paginate_button next">
          <a href="${pageMaker.endPage+1}">▶</a>
        </li>
      </c:if> 
        </ul>
      </div>
      <!-- END -->
      <form id="pageFrm" action="${cpath}/board/list" method="post">
         <!-- 게시물 번호(idx)추가 -->         
         <input type="hidden" id="page" name="page" value="${pageMaker.cri.page}"/>
         <input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
         <input type="hidden" name="type" value="${pageMaker.cri.type}"/>
         <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}"/>
      </form>      
      <!-- Modal 추가 -->
	  <div id="myModal" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">Modal Header</h4>
		      </div>
		      <div class="modal-body">		      		       
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		
		  </div>
		</div>
	  <!-- Modal END -->	
    </div>
    <div class="panel-footer">스프2탄(답변형 게시판 만들기)</div>
  </div>
</div>

</body>
</html>