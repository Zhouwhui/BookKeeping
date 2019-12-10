package servlet.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
public class LoginFilter extends HttpServlet implements Filter {
	
	@Override
	public void doFilter(ServletRequest sRequest, ServletResponse sResponse,
			FilterChain filterChain) throws IOException, ServletException {
		// 定义拦截规则，什么样的URL请求可以运行通过
		HttpServletRequest request = (HttpServletRequest) sRequest;      
        HttpServletResponse response = (HttpServletResponse) sResponse;      
        HttpSession session = request.getSession();    
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        List<String> notCheckLoginUrls = new ArrayList<String>(); //不检查登录的URL 
    	
        notCheckLoginUrls.add("login.jsp");
        notCheckLoginUrls.add("user/login");
        notCheckLoginUrls.add("register.jsp");
        notCheckLoginUrls.add("user/register");
        
        try{
			String requestUri = request.getRequestURI();
			
			if(requestUri.endsWith(".js") || requestUri.endsWith(".css")
					||requestUri.endsWith(".png") ||requestUri.endsWith(".jpg")
					||requestUri.endsWith(".ico") ||requestUri.endsWith(".gif")
					||requestUri.endsWith(".json") || requestUri.endsWith(".woff")
					||requestUri.endsWith(".tff") || requestUri.endsWith(".do")){
				filterChain.doFilter(sRequest, sResponse);  
            	return;
			}
			
			//请求url在excludedUrls中，这通过拦截
	        for (String url : notCheckLoginUrls) {
	            if (requestUri.endsWith(url)) { //属于不跳转的的页面
	            	filterChain.doFilter(sRequest, sResponse);  
	            	return;
	            }
	        }
	        
	        if (session.getAttribute("loginuser") == null) {
	            response.sendRedirect(request.getContextPath() + "/login.jsp");
	            return;
	        }
		}catch(Exception e){
			e.printStackTrace();
		}
		//通过的URL继续访问servlet容器，实现正常的请求
		filterChain.doFilter(sRequest, sResponse);    
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
