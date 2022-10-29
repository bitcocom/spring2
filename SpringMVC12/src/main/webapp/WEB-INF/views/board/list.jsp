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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="${cpath}/resources/css/style.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css"> 
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fefc41acd5be31226ac1be47352506ca"></script>
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
  	// 책 검색 버튼이 클릭 되었을때 처리
  	$("#search").click(function(){
  		var bookname=$("#bookname").val();
  		if(bookname==""){
  			alert("책 제목을 입력하세요");
  			return false;
  		}
  		// Kakao 책 검색 openAPI를 연동하기(키를발급)
  		// URL : https://dapi.kakao.com/v3/search/book?target=title
  		// H : Authorization: KakaoAK 260bf790c4b9969507dd7511de7de3ba
  		$.ajax({
  			url : "https://dapi.kakao.com/v3/search/book?target=title",
  			headers : {"Authorization": "KakaoAK 260bf790c4b9969507dd7511de7de3ba"},
  			type : "get",
  			data : {"query" : bookname},
  			dataType : "json",
  			success : bookPrint,
  			error : function(){ alert("error");}	
  		});
  		$(document).ajaxStart(function(){ $(".loading-progress").show(); });
  		$(document).ajaxStop(function(){ $(".loading-progress").hide(); });
  	});    	
  	// input box에 책 제목이 입려되면 자동으로 검색을하는 기능
  	$("#bookname").autocomplete({
  		source : function(){ 
  			var bookname=$("#bookname").val();
  			$.ajax({
      			url : "https://dapi.kakao.com/v3/search/book?target=title",
      			headers : {"Authorization": "KakaoAK 260bf790c4b9969507dd7511de7de3ba"},
      			type : "get",
      			data : {"query" : bookname},
      			dataType : "json",
      			success : bookPrint,
      			error : function(){ alert("error");}	
      		});
  		},
  		minLength : 1    		
  	});
  	// 지도 mapBtn 클릭시 지도가 보이도록 하기
  	$("#mapBtn").click(function(){
  		var address=$("#address").val();
  		if(address==''){
  			alert("주소를 입력하세요");
  			return false;
  		}
  		$.ajax({
  			url : "https://dapi.kakao.com/v2/local/search/address.json",
  			headers : {"Authorization": "KakaoAK 260bf790c4b9969507dd7511de7de3ba"},
  			type : "get",
  			data : {"query" : address},
  			dataType : "json",
  			success : mapView,
  			error : function() { alert("error"); }  			
  		});
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
  	 $("#myModal").modal('show');
   }
   function goMsg(){
  	 alert("삭제된 게시물입니다."); // Modal창
   }
   function bookPrint(data){
  	 var bList="<table class='table table-hover'>";
  	 bList+="<thead>";
  	 bList+="<tr>";
  	 bList+="<th>책이미지</th>";
  	 bList+="<th>책가격</th>";
  	 bList+="</tr>";
  	 bList+="</thead>";
  	 bList+="<tbody>";
  	 $.each(data.documents,function(index, obj){
  		 var image=obj.thumbnail;
  		 var price=obj.price;
  		 var url=obj.url;
  		 bList+="<tr>";
      	 bList+="<td><a href='"+url+"'><img src='"+image+"' width='50px' height='60px'/></a></td>";
      	 bList+="<td>"+price+"</td>";
      	 bList+="</tr>";
  	 }); 
  	 bList+="</tbody>";
  	 bList+="</table>";
  	 $("#bookList").html(bList);
   }
   function mapView(data){
	 var x=data.documents[0].x; // 경도
	 var y=data.documents[0].y; // 위도
  	 var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
  	    mapOption = { 
  	        center: new kakao.maps.LatLng(y, x), // 지도의 중심좌표
  	        level: 2 // 지도의 확대 레벨
  	    };
  	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
  	var map = new kakao.maps.Map(mapContainer, mapOption); 
  	
  	// 마커가 표시될 위치입니다 
  	var markerPosition  = new kakao.maps.LatLng(y, x); 

  	// 마커를 생성합니다
  	var marker = new kakao.maps.Marker({
  	    position: markerPosition
  	});
     
  	// 마커가 지도 위에 표시되도록 설정합니다
  	marker.setMap(map);
  	// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
  	var iwContent = '<div style="padding:5px;">${mvo.memName}</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
  	    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

  	// 인포윈도우를 생성합니다
  	var infowindow = new kakao.maps.InfoWindow({
  	    content : iwContent,
  	    removable : iwRemoveable
  	});

  	// 마커에 클릭이벤트를 등록합니다
  	kakao.maps.event.addListener(marker, 'click', function() {
  	      // 마커 위에 인포윈도우를 표시합니다
  	      infowindow.open(map, marker);  
  	});
   }
  </script>
 
</head>
<body>

  <div class="card">
    <div class="card-header">
	    <div class="jumbotron jumbotron-fluid">
		  <div class="container">
		    <h1>Spring Framework~~</h1>
		    <p>자바 TPC->나프1탄->나프2탄->스프1탄->스프2탄</p>
		  </div>
		</div>
    </div>
    <div class="card-body">
		<div class="row">
		  <div class="col-lg-2">
		    <jsp:include page="left.jsp"/>
		  </div>
		  <div class="col-lg-7">
	   <table class="table table-hover">
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
              <i class="bi bi-arrow-return-right"></i>           
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
            <button id="regBtn" class="btn btn-sm btn-secondary pull-right">글쓰기</button>            
          </td>
        </tr>
        </c:if>
      </table>
       <!-- 검색메뉴 -->
      <form class="form-inline" action="${cpath}/board/list" method="post">
	   <div class="container">
	   <div class="input-group mb-3">
	      <div class="input-group-append">
		     <select name="type" class="form-control">
		      <option value="writer" ${pageMaker.cri.type=='writer' ? 'selected' : ''}>이름</option>
		      <option value="title" ${pageMaker.cri.type=='title' ? 'selected' : ''}>제목</option>
		      <option value="content" ${pageMaker.cri.type=='content' ? 'selected' : ''}>내용</option>
		   </select>
		  </div>
		  <input type="text" class="form-control" name="keyword" value="${pageMaker.cri.keyword}">
		  <div class="input-group-append">
		    <button class="btn btn-success" type="submit">Search</button>
		  </div>
		</div>
		</div>
       </form>    
      <!-- 페이징 START -->
      <ul class="pagination justify-content-center">
      <!-- 이전처리 -->
      <c:if test="${pageMaker.prev}">
        <li class="paginate_button previous page-item">
          <a class="page-link" href="${pageMaker.startPage-1}">Previous</a>
        </li>
      </c:if>      
      <!-- 페이지번호 처리 -->
          <c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
	         <li class="paginate_button ${pageMaker.cri.page==pageNum ? 'active' : ''} page-item"><a class="page-link" href="${pageNum}">${pageNum}</a></li>
		  </c:forEach>    
      <!-- 다음처리 -->
      <c:if test="${pageMaker.next}">
        <li class="paginate_button next page-item">
          <a class="page-link" href="${pageMaker.endPage+1}">Next</a>
        </li>
      </c:if> 
        </ul>
   
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
		        <h4 class="modal-title">MESSAGE</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>		        
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
		  <div class="col-lg-3">
		    <jsp:include page="right.jsp"/>
		  </div>
		</div>
    </div> 
    <div class="card-footer">인프런_스프2탄_박매일</div>
  </div>


</body>
</html>
