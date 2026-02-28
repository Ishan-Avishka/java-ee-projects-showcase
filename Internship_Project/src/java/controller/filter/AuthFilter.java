package controller.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {
    
    public void init(FilterConfig filterConfig) throws ServletException {
        
    }

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);
        
        String path = request.getRequestURI().substring(request.getContextPath().length());
        
        if (path.equals("/login.jsp") || path.equals("/registerStudent.jsp") || 
            path.equals("/index.jsp") || path.equals("/login") || path.equals("/register") || 
            path.startsWith("/css/") || path.startsWith("/js/") || path.equals("/")) {
            chain.doFilter(req, res);
            return;
        }
        
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String role = (String) session.getAttribute("role");
        
        if (path.contains("dashboardAdmin") || path.contains("/admin/")) {
            if (!"Admin".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
        }
        
        if (path.contains("dashboardCompany") || path.contains("postInternship") || path.contains("/company/")) {
            if (!"Company".equals(role) && !"Admin".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
        }
        
        if (path.contains("dashboardStudent") || path.contains("applyInternship") || path.contains("/student/")) {
            if (!"Student".equals(role) && !"Admin".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
        }
        
        chain.doFilter(req, res);
    }

    public void destroy() {
        
    }
}