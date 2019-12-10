package controller.service;

import java.io.IOException;
import java.io.Writer;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.TBookkeeping;
import model.TUser;
import model.VBookkeeping;
import model.VSortType;
import model.VStatistics;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import util.LayuiData;

import com.alibaba.fastjson.JSON;

import business.dao.BookKeepDAO;
import business.dao.SortTypeDAO;
import business.dao.UserDAO;
import business.impl.BookKeepDAOImpl;
import business.impl.SortTypeDAOImpl;
import business.impl.UserDAOImpl;
@Controller
@RequestMapping(value = "bookkeep")
public class BookKeepController {
		private Writer out;
		private BookKeepDAO bok = new BookKeepDAOImpl();
		private LayuiData laydata = new LayuiData();
		@RequestMapping(value="bookkeepselect")
		public void bookkeepselect(HttpServletRequest request, HttpServletResponse response, Model model,
				String payid,String sortid,String datetime,String remark,int limit,int page) throws IOException{
			HttpSession session = request.getSession();
			TUser loginUser  = (TUser)session.getAttribute("loginuser");
			String where="";
			if(payid!=null&&payid!=""){
				where += " and payid="+payid;
			}
			if(sortid!=null&&sortid!=""){
				where += " and sortid="+sortid;
			}
			if(datetime!=null&&datetime!=""){
				where += " and datetime like'%"+payid+"%'";
			}
			if(remark!=null&&remark!=""){
				where += " and remark like'%"+payid+"%'";
			}
			List<VBookkeeping> list = bok.selectUserALL(loginUser.getUserid(),where);
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
		}
		@RequestMapping(value="getsort")
		public void getsort(HttpServletRequest request, HttpServletResponse response, Model model,
				int type) throws IOException
		{
			HttpSession session = request.getSession();
			TUser loginUser  = (TUser)session.getAttribute("loginuser");
			List<VSortType> list = bok.getAllSortType(loginUser.getUserid(),type);
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
		}
		@RequestMapping(value="getallsort")
		public void getallsort(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException
		{
			HttpSession session = request.getSession();
			TUser loginUser  = (TUser)session.getAttribute("loginuser");
			SortTypeDAO sdao = new SortTypeDAOImpl();
			List<VSortType> list = sdao.getAllSortType(loginUser.getUserid());
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
		}
		@RequestMapping(value="addbookeep")
		public void addbookeep(HttpServletRequest request, HttpServletResponse response, Model model,
				double money,String datetime,int payid,int sortid,int type,String remark) throws IOException{
			HttpSession session = request.getSession();
			TUser loginUser  = (TUser)session.getAttribute("loginuser");
			if(type == 0){
				loginUser.setTotalmoney(loginUser.getTotalmoney()-money);
			}else{
				loginUser.setTotalmoney(loginUser.getTotalmoney()+money);
			}
			session.setAttribute("loginuser", loginUser);
			TBookkeeping bookkeep = new TBookkeeping();
			bookkeep.setDatetime(datetime);
			bookkeep.setMoney(money);
			bookkeep.setPayid(payid);
			bookkeep.setRemark(remark);
			bookkeep.setSortid(sortid);
			bookkeep.setType(type);
			bookkeep.setUserid(loginUser.getUserid());
			boolean flag = bok.addBookKeep(bookkeep);
			if(flag){
				laydata.code = LayuiData.SUCCESS;
				laydata.msg = "添加成功";
			} else {
				laydata.code = LayuiData.ERRR;
				laydata.msg = "添加失败";
			}
			out = response.getWriter();
			out.write(JSON.toJSONString(laydata));
			out.flush();
			out.close();
		}
		@RequestMapping(value="editbookeep")
		public void editbookeep(HttpServletRequest request, HttpServletResponse response, Model model,
				int bookkeepid,double money,String datetime,int payid,int sortid,String remark,String type) throws IOException{
			HttpSession session = request.getSession();
			TUser loginUser  = (TUser)session.getAttribute("loginuser");
			TBookkeeping oldbookkeep = bok.selectById(bookkeepid);
			if(oldbookkeep!=null){
				double newmoney = oldbookkeep.getMoney()-money;
				if(type.equals("0")){
					loginUser.setTotalmoney(loginUser.getTotalmoney()-newmoney);
				}else{
					loginUser.setTotalmoney(loginUser.getTotalmoney()+newmoney);
				}
				session.setAttribute("loginuser", loginUser);
				TBookkeeping bookkeep = new TBookkeeping();
				bookkeep.setDatetime(datetime);
				bookkeep.setMoney(money);
				bookkeep.setPayid(payid);
				bookkeep.setRemark(remark);
				bookkeep.setSortid(sortid);
				bookkeep.setType(Integer.parseInt(type));
				bookkeep.setId(bookkeepid);
				boolean flag = bok.editBookKeep(bookkeep);
				if(flag){
					laydata.code = LayuiData.SUCCESS;
					laydata.msg = "编辑成功";
				} else {
					laydata.code = LayuiData.ERRR;
					laydata.msg = "编辑失败";
				}
			}else{
				laydata.code = LayuiData.ERRR;
				laydata.msg = "未查询到相关信息";
			}
			out = response.getWriter();
			out.write(JSON.toJSONString(laydata));
			out.flush();
			out.close();
		}
		@RequestMapping(value="delbookeep")
		public void delbookeep(HttpServletRequest request, HttpServletResponse response, Model model,
				int bookkeepid) throws IOException{
			HttpSession session = request.getSession();
			TUser loginUser  = (TUser)session.getAttribute("loginuser");
			TBookkeeping oldbookkeep = bok.selectById(bookkeepid);
			if(oldbookkeep!=null){
				if(oldbookkeep.getType() == 0){
					loginUser.setTotalmoney(loginUser.getTotalmoney()-oldbookkeep.getMoney());
				}else{
					loginUser.setTotalmoney(loginUser.getTotalmoney()+oldbookkeep.getMoney());
				}
				session.setAttribute("loginuser", loginUser);
				boolean flag = bok.delBookKeep(bookkeepid);
				if(flag){
					laydata.code = LayuiData.SUCCESS;
					laydata.msg = "删除成功";
				} else {
					laydata.code = LayuiData.ERRR;
					laydata.msg = "删除失败";
				}
			}else{
				laydata.code = LayuiData.ERRR;
				laydata.msg = "未查询到相关信息";
			}
			out = response.getWriter();
			out.write(JSON.toJSONString(laydata));
			out.flush();
			out.close();
		}
	}

