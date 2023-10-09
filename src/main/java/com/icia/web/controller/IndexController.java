package com.icia.web.controller;

import javax.servlet.http.HttpServletRequest;




import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.icia.web.util.NaverApi;


@Controller("indexController")
public class IndexController
{
	private static Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	@RequestMapping(value = "/index")
   	public String index(HttpServletRequest request, HttpServletResponse response)
	{
		return "/index/index";
	}
	
	@RequestMapping(value= "/index/event")
	public String event(HttpServletRequest request, HttpServletResponse response)
	{
		return "/index/event";
	}
}