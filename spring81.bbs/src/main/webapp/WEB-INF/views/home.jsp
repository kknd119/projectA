<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" /> 
    <title>Home</title>
</head>
<body>   
    <p>  The time on the server is ${serverTime}. </p>
    <hr />
    
    
    <h2> 로그인 처리 </h2>
    <ol>
        <li> UserController 만들기 </li>
        <li> <a href="/user/"                target="_blank">/user/                </a> </li>
        <li> <a href="/user/login"           target="_blank">/user/login           </a> </li>
        <li> <a href="/user/logout"          target="_blank">/user/logout          </a> </li>
        <li> 
            <a href="/user/register"         target="_blank">/user/register        </a>
            <ul>
                <li><a href="/rest/checkuserid?userid=aaa"        target="_blank">/rest/checkuserid?userid=aaa     </a></li>
                <li><a href="/rest/checkuserid?userid=userid"        target="_blank">/rest/checkuserid?userid=userid     </a></li>
            </ul> 
        </li>
        <li> <a href="/user/usermodify"      target="_blank">/user/usermodify          </a> </li>
        <li> <a href="/user/changepassword"  target="_blank">/user/changepassword  </a> </li>        
        <li> <a href="/user/unregister"      target="_blank">/user/unregister      </a> </li>
        <li>jsp 파일에 layout include 하기
            <ul> 
                <li> login.jsp      </li>
                <li> register.jsp    </li>
                <li> usermodify.jsp      </li>
                <li> changepassword.jsp     </li>
            </ul>
            <xmp>
<div id="wrap">
    <div id="header">
        < %@ include file="../inc/header.jsp" % >
    </div>

    <div id="main-menu">
        < %@ include file="../inc/main-menu.jsp" % >
    </div> 

    <div id="container">
    </div>
        
    <div id="sidebar">
        < %@ include file="../inc/bbs-menu.jsp" % >
    </div>
    
    <div id="extra">
        < %@ include file="../inc/extra.jsp" % >
    </div>

    <div id="footer">
        < %@ include file="../inc/footer.jsp" % >
    </div>     
</div>            
            </xmp>
        </li>
    </ol>  
    
    <hr />
    
    <h2>board 게시판 만들기</h2>  
    
    <ol>
        <li><a href="/board/boardlist"  target="_blank">/board/boardlist </a></li>
        <li><a href="/board/boardlist?searchWord="  target="_blank">/board/boardlist?searchWord= </a></li>
        <li><a href="/board/boardlist?searchWord=자유게시판"  target="_blank">/board/boardlist?searchWord=자유게시판 </a></li>
        <br />
        
        <li><a href="/board/boardview?boardcd=qna" target="_blank">/board/boardview?boardcd=qna </a></li>
        <li><a href="/board/boardview" target="_blank">/board/boardview  == /board/boardview?boardcd=free</a></li>
        <br />
        
        <li><a href="/board/boardview/qna" target="_blank">/board/boardview/qna </a>  &nbsp;&nbsp; @Pathvarable을 사용</li>
        <br />
        
        <li><span> boardlist 에 boardview 연결하기 </span> <br />
            <span> boardlist의 tr을 클릭하면 boardview 가 열리게 하시오 </span>
            <xmp>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script>    
        $(document).ready( function(e){             
            //boardlist에서 해당 게시글을 클릭하면 boardview 가 열리게 하시오
            $('#bbs tr[boardcd]').click( function(e){
                var boardcd = $(this).attr('boardcd');
                window.location='/board/boardview/' + boardcd ;
            });
        });
    </script> 
            </xmp>        
        </li>
        <li><a href="/board/boardmodify?boardcd=qna" target="_blank">/board/boardmodify?boardcd=qna</a></li>
        <li><a href="/board/boardmodify/qna" target="_blank">/board/boardmodify/qna</a></li>
        <li><span> boardview 에 boardmodify 연결하기 </span></li>
        <br />
        
        <li><a href="/board/boardwrite" target="_blank">/board/boardwrite</a></li>
        <li><span> boardlist와 boardview 에 boardwrite 연결하기 </span></li>
        <br />
        
        <li><a href="/board/boarddelete" target="_blank">/board/boarddelete</a>  
            <br />delete는 반드시 post로 만들어야 한다. get으로 만들어서는 안된다.
            <ul> 
                <li>ajax를 이용하는 방법</li>
                <li>form을 이용하는 방법</li>
            </ul>
        </li>
        <br />
        
        <li><span> boardview 에 boarddelete 연결하기 </span></li>
        <br />
        
        <li><span> /board/boardlist?curPage=1&searchWord=  에 페이징 기능 추가 </span></li>
        <li><span> boardview 에 boarddelete 연결하기 </span></li>
        <br />
        
        <li><span> /board/boardlist?curPage=1&searchWord=  에 searchWord를 이용한 검색 기능 추가 </span></li>
        <br />
        
        <li>jsp 파일에 layout include 하기
            <ul> 
                <li> boardlist.jsp      </li>
                <li> boardmodify.jsp    </li>
                <li> boardview.jsp      </li>
                <li> boardwrite.jsp     </li>
            </ul>
            <xmp>
<div id="wrap">
    <div id="header">
        < %@ include file="../inc/header.jsp" % >
    </div>

    <div id="main-menu">
        < %@ include file="../inc/main-menu.jsp" % >
    </div> 

    <div id="container">
    </div>
        
    <div id="sidebar">
        < %@ include file="bbs-menu.jsp" % >
    </div>
    
    <div id="extra">
        < %@ include file="../inc/extra.jsp" % >
    </div>

    <div id="footer">
        < %@ include file="../inc/footer.jsp" % >
    </div>     
</div>            
            </xmp>
        </li>
    </ol>    
    <hr />
    
    
    
    <h2>article 게시판 만들기</h2>  
    <ul>
        <li><a href="/board/articlelist"  target="_blank">/board/articlelist    (GET)</a> </li>
        <li><a href="/board/articlelist/free"  target="_blank">/board/articlelist/free    (GET)</a> </li>
        <li><a href="/board/articlelist/free?curPage=1&searchWord="  target="_blank">/board/articlelist/free?curPage=1&searchWord=    (GET)</a> </li>
        <li><span> /board/articlelist/free?curPage=1&searchWord= 에 searchWord를 이용한 검색 기능 추가 </span></li>
          
        <li><span> articlelist 에 articleview 연결하기 </span> </li>
        <li>
            <span> articlelist의 tr을 클릭하면 articleview 가 열리게 하시오 </span>
            <xmp>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script>    
        $(document).ready( function(e){             
            //boardlist에서 해당 게시글을 클릭하면 articleview 가 열리게 하시오
            $('#bbs tr[articleno]').click( function(e){
                var articleno = $(this).attr('articleno');
                window.location.href ='/board/articleview/${boardcd}/' + articleno ;
            });
        });
    </script> 
            </xmp>        
        </li>
        <br />
        
        <li><a href="/board/articleview/free/1"   target="_blank">/board/articleview/free/1  (GET)</a></li>
        <li><a href="/board/articleview/free/1?curPage=1&searchWord="   target="_blank">/board/articleview/free/1?curPage=1&amp;searchWord=   (GET)</a></li>
        <li><span> /board/articleview/free/1?curPage=1&searchWord= 에 페이징 기능 추가 </span></li>
        <li><span> /board/articleview/free/1?curPage=1&searchWord= 에 searchWord를 이용한 검색 기능 추가 </span></li>
        <li><span>articleview 의 게시글 목록에서 tr을 클릭하면 해당 게시글이 열리게 하시오</span></li>
        <li><span>articleview 의 버튼 기능 추가. "수정", "삭제", "다음글", "이전글", "목록", "새글쓰기"</span></li>
        
        <li><span>articleview 에서 쿠키를 이용하여 조회수를 1일 동안 증가시키는 것을 막으시오. </span></li>
        <br />
        
        <li><a href="/board/articlewrite/free"  target="_blank">/board/articlewrite/free (GET,POST)</a>
            <ol>
                <li><span>글쓴 후 articleview 에서 게시글 보이게 </span></li>
            </ol>            
        </li>
        <li><span>articleview 에서 첨부파일 다운로드 기능을 추가 </span>
            <ol>
                <li><span>download.jsp 추가</span></li>
                <li><a href="/download" target="_blank">/download </a> </span></li>
            </ol> 
        </li>
        <br />
        
        <li><a href="/board/articlemodify/free/1?curPage=1&searchWord=" target="_blank">/board/articlemodify/free/1?curPage=1&amp;searchWord= (GET,POST)</a></li>
        <li><span>articlemodify 에서 첨부파일 삭제 기능을 추가 </span></li>
        <br />
        
        <li><a href="/board/articledelete/free/1?curPage=1&searchWord=" target="_blank">/board/articledelete/free/1?curPage=1&amp;searchWord= (POST)</a></li>
        <br />
        
        <li>jsp 파일에 layout include 하기
            <ul> 
                <li> boardlist.jsp      </li>
                <li> boardmodify.jsp    </li>
                <li> boardview.jsp      </li>
                <li> boardwrite.jsp     </li>
            </ul>
            <xmp>
<div id="wrap">
    <div id="header">
        < %@ include file="../inc/header.jsp" % >
    </div>

    <div id="main-menu">
        < %@ include file="../inc/main-menu.jsp" % >
    </div> 

    <div id="container">
    </div>
        
    <div id="sidebar">
        < %@ include file="bbs-menu.jsp" % >
    </div>
    
    <div id="extra">
        < %@ include file="../inc/extra.jsp" % >
    </div>

    <div id="footer">
        < %@ include file="../inc/footer.jsp" % >
    </div>     
</div>            
            </xmp>
    </ul>
    <br />
    <hr />
    
    <h2> RestController </h2>    
    <ol>
        <li>build.gradle 라이브러리 추가
            <xmp>
    // json library :: @ResponseBody를 이용해 json 데이터를 반환하기 위한 라이브러리
    compile "org.codehaus.jackson:jackson-mapper-asl:1.9.13"
            </xmp>
        </li>
        <li>RestConroller.java 만들기</li> 
        <br />   
        <li><a href="/board/articleview/free/1"   target="_blank">/board/articleview/free/1  (GET)</a></li>
        <li>댓글용 rest 서비스 만들기
            <ol>
                <li>/rest/insertcomment   만들기 (POST)
                    <ol>
                        <li>json 으로 0 또는 1의 결과를 반환 받는지 확인</li>
                        <li>html 로 반환 받게 변경 </li>
                    </ol>
                </li>
                <li>/rest/getcomment      만들기 (GET,POST)</li>
                <li>/rest/getcommentlist  만들기 (GET,POST)</li>
                <li>/rest/updatecomment   만들기 (POST)</li>
                <li>/rest/deletecomment   만들기 (POST)</li>
            </ol>
        </li>
    </ol>  
    
    <hr />
   
    
    <h2> 오류 페이지 설정 </h2>
    <ol>
        <li>web.xml 에 아래 내용 추가</li>
    </ol>
  
    <xmp>
        <!-- 에러 페이지 설정 -->
        <error-page>
            <error-code>403</error-code>
            <location>/WEB-INF/views/common/error.jsp</location>
        </error-page>
    
        <error-page>
            <error-code>404</error-code>
            <location>/WEB-INF/views/common/error/404.jsp</location>
        </error-page>
    
        <error-page>
            <error-code>500</error-code>
            <location>/WEB-INF/views/common/error/500.jsp</location>
        </error-page>  
    </xmp>
    <hr />
   
</body>
</html>
