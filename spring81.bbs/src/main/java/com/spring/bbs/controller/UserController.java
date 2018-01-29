package com.spring.bbs.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.bbs.common.WebConstants;
import com.spring.bbs.inf.IServiceUser;
import com.spring.bbs.model.ModelUser;

@Controller
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	IServiceUser svruser;
	
	@RequestMapping(value = "/user/", method = RequestMethod.GET)
	public String home(Model model) {
        logger.info("/user/");
        
        return "redirect:/user/login";
	}
	
    @RequestMapping(value = "/user/login", method = RequestMethod.GET)
    public String login(Model model
            , @RequestParam(value="url", defaultValue="") String url 
            , HttpServletRequest request) {
        logger.info("/user/login : get ");
        
        // 로그인 후 이동할 페이지를 변수로 넘긴다.
        if( url.isEmpty() )
            url = request.getHeader("Refer");
        
        model.addAttribute("url", url );
        
        return "user/login"; // views/ user/ login.jsp
    }

    @RequestMapping(value = "/user/login", method = RequestMethod.POST)
    public String login(Model model
            , @RequestParam String url
            , @RequestParam String userid 
            , @RequestParam String passwd
            , HttpSession session
            , RedirectAttributes  rttr ) {
        logger.info("/user/login : post");
        
        ModelUser result = svruser.login(userid, passwd);
        
        if(result != null ) { // 로그인 성공
            
            session.setAttribute( /* 세션명*/ WebConstants.SESSION_NAME
                                , /* 세션값*/ result);
            
            if( url.isEmpty() )
                return "redirect:/"; // --> http://localhost/ 페이지가 열림.
            else
                return "redirect:" + url; 
        }
        else {  // 로그인 실패     
            // RedirectAttributes는 redirect 시 사용되는 변수를 전달할 때 사용되는 객체다.
            rttr.addFlashAttribute("msg", "로그인실패");
            rttr.addFlashAttribute("url", url );
            
            return "redirect:/user/login"; // views/ user/ login.jsp
        }        
    }
        
    @RequestMapping(value = "/user/logout", method = RequestMethod.GET)
    public String login(Model model , HttpSession session) {
        logger.info("/user/logout : get ");
        
        // 세션 삭제
        session.removeAttribute( WebConstants.SESSION_NAME );
        
        // DB 에서 로그아웃 정보 남기기. 생략.
        
        return "redirect:/"; 
    }

    @RequestMapping(value = "/user/register", method = RequestMethod.GET)
    public String register(Model model ) {
        logger.info("/user/register : get ");
        
        return "user/register"; // views / user / register.jsp 
    }


    @RequestMapping(value = "/user/register", method = RequestMethod.POST)
    public String register(Model model
                          , @ModelAttribute ModelUser user ) {
        logger.info("/user/register : post ");
        
        // DB insert
        int result = svruser.insertUser( user );
        
        return "user/register_post"; // views / user / register.jsp 
    }

    @RequestMapping(value = "/user/usermodify", method = RequestMethod.GET)
    public String modify(Model model
            , HttpSession session) {
        logger.info("/user/usermodify : get ");
        
        // 로그인이 돼었다는 가정. 세션에 사용자 정보가 들어 있음.
        ModelUser user = (ModelUser) session.getAttribute( WebConstants.SESSION_NAME );

        if( user == null )
            throw new RuntimeException( WebConstants.NOT_LOGIN);
        
        // DB에서 회원 정보 조회.
        user = svruser.selectUserOne(user);
        if( user == null ) {
            
            return "redirect:/user/login";
        }
        
        model.addAttribute("user", user);
        
        return "user/usermodify"; // views / user / register.jsp 
    }
    

    @RequestMapping(value = "/user/usermodify", method = RequestMethod.POST)
    public String modify(Model model
            , @ModelAttribute ModelUser setValue
            , HttpSession session
            , RedirectAttributes  rttr) {
        logger.info("/user/usermodify : post ");
        
        // 로그인이 돼었다는 가정. 세션에 사용자 정보가 들어 있음.
        ModelUser user = (ModelUser) session.getAttribute( WebConstants.SESSION_NAME );
        
        if( user == null )
            throw new RuntimeException( WebConstants.NOT_LOGIN);
       
        // 입력된 패스워드와 현재의 패스워드가 같은지 확인. 
        // 패스워드는 DB에 암호화 되어 저장되기 때문에..
        int r = svruser.checkpassword(setValue.getUserid(), setValue.getPasswd() );
        if( r == 0  )
            throw new RuntimeException( WebConstants.ERROR_PASSWORD );
        
        // DB에서 회원 정보 수정.
        ModelUser whereValue = new ModelUser();
        whereValue.setUserid( user.getUserid() );
        
        setValue.setPasswd( null ); // 패스워드 변경하지 않기 위해 null 값을 넣음.
        
        int result = svruser.updateUserInfo(setValue, whereValue);       
        
        if( result > 0 ) {            
            // session 정보 갱신
            user = svruser.selectUserOne(user);
            session.setAttribute(WebConstants.SESSION_NAME, user);
            
            return "user/changepassword"; // views / user / register.jsp
        }
        else {
            rttr.addFlashAttribute("user", setValue);
            rttr.addFlashAttribute("msg" , WebConstants.UPDATE_FAIL);
            
            return "redirect:/user/usermodify"; 
        }
    }
    
    @RequestMapping(value = "/user/changepassword", method = RequestMethod.GET)
    public String changepassword(Model model
            , HttpSession session) {
        logger.info("/user/changepassword : get ");
        
        // 로그인이 돼었다는 가정. 세션에 사용자 정보가 들어 있음.
        ModelUser user = (ModelUser) session.getAttribute( WebConstants.SESSION_NAME );

        if( user == null )
            throw new RuntimeException( WebConstants.NOT_LOGIN);
        
        if( user == null ) 
            return "redirect:/user/login";
        else
            return "user/changepassword"; // views / user / changepassword.jsp 
    }
    
    @RequestMapping(value = "/user/changepassword", method = RequestMethod.POST)
    public String changepassword(Model model
            , HttpSession session
            , @RequestParam String currentPasswd
            , @RequestParam String newPasswd
            , RedirectAttributes rttr ) {
        logger.info("/user/changepassword : post ");

        // 로그인이 돼었다는 가정. 세션에 사용자 정보가 들어 있음.
        ModelUser user = (ModelUser) session.getAttribute( WebConstants.SESSION_NAME );

        if( user == null )
            throw new RuntimeException( WebConstants.NOT_LOGIN);
        
        int result = svruser.updatePasswd(user.getUserid(), currentPasswd, newPasswd);
        if( result == 1 ) {
            return "user/changepassword_post"; // views / user / changepassword_post.jsp
        }
        else {
            rttr.addFlashAttribute("msg", WebConstants.MSG_FAIL_CHANGE_PASSWORD);
            return "redirect:/user/changepassword";
        }
    }
    

    @RequestMapping(value = "/user/unregister", method = RequestMethod.GET)
    public String unregister(Model model ) {
        logger.info("/user/unregister : get ");
        
        return "user/unregister"; // views / user / unregister.jsp 
    }

    @RequestMapping(value = "/user/unregister", method = RequestMethod.POST)
    public String unregister(Model model
            , @RequestParam String email
            , @RequestParam String passwd
            , HttpSession session) {
        logger.info("/user/unregister : post ");

        // 로그인이 돼었다는 가정. 세션에 사용자 정보가 들어 있음.
        ModelUser user = (ModelUser) session.getAttribute( WebConstants.SESSION_NAME );

        if( user == null )
            throw new RuntimeException( WebConstants.NOT_LOGIN);
        
        user.setEmail( email );
        user.setPasswd( passwd );
        
        // DB에서 탈퇴 처리
        int result = svruser.updateRetire( user );
                
        // 탈퇴 처리가 성공하면 세션 삭제.
        if( result == 1 ) {
            session.removeAttribute( WebConstants.SESSION_NAME );
            return "user/unregister_post"; // views / user / unregister_post.jsp
        }
        else 
            return "user/unregister";
    }
}
