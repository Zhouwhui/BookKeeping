package controller.service;

import java.io.IOException;
import java.io.Writer;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Piechart;
import model.TUser;
import model.VStatistics;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import util.LayuiData;

import com.alibaba.fastjson.JSON;

import business.dao.StatisticsDAO;
import business.impl.StatisticsDAOImpl;

@Controller
@RequestMapping(value = "statistics")
public class StatisticsController {
	private StatisticsDAO sdao = new StatisticsDAOImpl();
	private LayuiData laydata = new LayuiData();
	private Writer out;
	@RequestMapping(value = "year")
	public void year(HttpServletRequest request, HttpServletResponse response, Model model,
			String year){
		try {
			HttpSession session = request.getSession();
			TUser user = (TUser)session.getAttribute("loginuser");
			List<VStatistics> list = sdao.getGraph(year,user.getUserid());
			if(list!=null&&list.size()>0){
				laydata.code = LayuiData.SUCCESS;
				laydata.msg = "执行成功";
				laydata.data = list;
			} else {
				laydata.code = LayuiData.ERRR;
				laydata.msg = "无数据";
			}
			out = response.getWriter();
			out.write(JSON.toJSONString(laydata));
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "month")
	public void month(HttpServletRequest request, HttpServletResponse response, Model model,
			String year,String month){
		try {
			HttpSession session = request.getSession();
			TUser user = (TUser)session.getAttribute("loginuser");
			List<Piechart> list = sdao.getStatisics(year, month,user.getUserid());
			if(list!=null&&list.size()>0){
				laydata.code = LayuiData.SUCCESS;
				laydata.msg = "执行成功";
				laydata.data = list;
			} else {
				laydata.code = LayuiData.ERRR;
				laydata.msg = "无数据";
			}
			out = response.getWriter();
			out.write(JSON.toJSONString(laydata));
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
