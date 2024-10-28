<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.getSession().invalidate(); // Invalidate the session
    response.sendRedirect("login.jsp"); // Redirect to login page
%>
