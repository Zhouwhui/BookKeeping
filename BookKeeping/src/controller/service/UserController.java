package controller.service;

import java.io.IOException;
import java.io.Writer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.TUser;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import business.dao.UserDAO;
import business.impl.UserDAOImpl;

@Controller
@RequestMapping(value = "user")
public class UserController {
	private Writer out;
	private UserDAO udao = new UserDAOImpl();
	
	@RequestMapping(value="login")
	public void login(HttpServletRequest request, HttpServletResponse response, Model model,
			String userid,String pwd) throws IOException{
		TUser loginuser = udao.login(userid, pwd);
		if(loginuser!=null && !loginuser.getUserid().equals("")){
			HttpSession session = request.getSession();
			session.setAttribute("loginuser", loginuser);
			out = response.getWriter();
			out.write("登录成功");
			out.flush();
			out.close();
		}else{
			out = response.getWriter();
			out.write("登录失败");
			out.flush();
			out.close();
		}
	}
	
	@RequestMapping(value="register")
	public void register(HttpServletRequest request, HttpServletResponse response, Model model,
			String userid,String username,String pwd) throws IOException{
		TUser user = new TUser();
		user.setUserid(userid);
		user.setUsername(username);
		user.setPwd(pwd);
		user.setTotalmoney(0.0);
		boolean flag = udao.register(user);
		if(flag){
			out = response.getWriter();
			out.write("添加成功");
			out.flush();
			out.close();
		}else{
			out = response.getWriter();
			out.write("添加失败");
			out.flush();
			out.close();
		}
	}
	
	@RequestMapping(value="logout")
	public void login(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException{
		HttpSession session = request.getSession();
		session.removeAttribute("loginuser");
		Writer out = response.getWriter();
		out.write("成功");
		out.flush();
		out.close();
	}
}
