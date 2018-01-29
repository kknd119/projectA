<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<html>
<head>
    <meta charset="utf-8" /> 
    <meta name="Keywords" content="게시판 수정하기 폼" />
    <meta name="Description" content="게시판 수정하기 폼" />
    
    <title>${boardnm }</title>
    
    <link rel="stylesheet" href="/resources/css/screen.css" type="text/css" media="screen" />
    <script src="/resources/js/jquery-3.1.1.js"></script>
    <script src="/resources/js/ajaxsetup.js"><!-- jquery 아래에 위치해야 함 --></script>
    <script>
        $(document).ready( function(event){
        	$('div[attachfileno]').click( function(event){
        		
        		if( confirm("정말로 삭제하시겠읍니까?") ) {
        			    var attachfileno = $(this).attr('attachfileno');
        			    
                        // ajax 호출
                        $.ajax({
                            url : '/board/deleteattachfile'
                            , data: { 'attachfileno' : attachfileno }        // 사용하는 경우에는 { 'data1':'test1', 'data2':'test2' }
                            , type: 'post'      // get, post
                            , timeout: 30000    // 30초
                            , dataType: 'json'  // text, html, xml, json, jsonp, script
                        }).done( function(data, textStatus, xhr ){
                            // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
                            if( data === 1) { // 삭제 성공
                                $('div[attachfileno="' + attachfileno + '"]').remove();
                            }
                            else { // 삭제 실패
                                alert('삭제 실패');
                            }
                        });        			
        		}
        		
        	});
        });
    </script>
</head>
<body>

	<div id="wrap">

		<div id="container">
			<div id="content" style="min-height: 800px;">
				<div id="url-navi">BBS</div>

				<!-- 본문 시작 -->
				<h1>${boardnm }</h1>
				<div id="bbs">
					<h2>수정</h2>
					<form id="modifyForm" action="${actionurl}" method="post" enctype="multipart/form-data" >
						<p style="margin: 0; padding: 0;">
							<input type="hidden" name="articleno" value="${articleno }" />
							<input type="hidden" name="boardcd" value="${boardcd }" />
							<input type="hidden" name="curPage" value="${curPage }" />
							<input type="hidden" name="searchWord" value="${searchWord }" />
						</p>
						<table id="write-form">
							<tr>
								<td>제목</td>
								<td><input type="text" name="title" size="50"
									value="${thisArticle.title }" /></td>
							</tr>
							<tr>
								<td colspan="2"><textarea name="content" rows="17">${thisArticle.content }</textarea>
								</td>
							</tr>
                            <tr>
                                <td>첨부 파일 목록</td>
                                <td>
                                    <c:forEach var="file" items="${attachFileList }" varStatus="status">
                                    <div attachfileno="${file.attachfileno }"> ${file.filenameorig } <b>X</b> </div>
                                    </c:forEach>
                                </td>
                            </tr>
							<tr>
								<td>파일첨부</td>
								<td><input type="file" name="upload" /></td>
							</tr>
						</table>
						<div style="text-align: center; padding-bottom: 15px;">
							<input type="submit" value="전송" /> 
							<input type="button" value="상세보기" onclick="goView()" /> 
							<input type="button" value="목록" onclick="goList()" />
						</div>
					</form>

				</div>
				<!-- bbs 끝 -->
				<!--  본문 끝 -->
			</div>
			<!-- content 끝 -->
		</div>
		<!--  container 끝 -->

	</div>


</body>
</html>
