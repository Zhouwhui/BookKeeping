package controller.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.TSortType;
import model.TUser;
import model.TUserSortType;
import model.VBookkeeping;
import model.VSortType;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import util.LayuiData;
import util.LayuiTableData;
import business.dao.SortTypeDAO;
import business.impl.SortTypeDAOImpl;

import com.alibaba.fastjson.JSON;

/**
 * ������Ϣ���ݽ���
 * @author sunst
 * @version 2019-9-7
 */
@Controller
@RequestMapping(value="/sorttype")
public class SortTypeController {
	private Writer out;
	private SortTypeDAO sdao = new SortTypeDAOImpl();
	private LayuiData laydata = new LayuiData();
	
	@RequestMapping(value="addsorttype")
	public void SortType(
			String sortname,
			int types,
			Model model,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		
		try {
			int isPro = sdao.selectSortTypeByName(sortname);
			if (isPro <= 0) {
				TSortType sortType = new TSortType();
				sortType.setPhotoid(16);;
				sortType.setSortname(sortname);
				sortType.setTypes(types);
				
				HttpSession session = request.getSession();
				TUser loginUser  = (TUser)session.getAttribute("loginuser");
				int result = sdao.addSortType(sortType);
				
				if (result > 0) {
					laydata.code = LayuiData.SUCCESS;
					laydata.msg = "��ӳɹ�";
					TSortType list= sdao.getTSortTypeByname(sortname);
					String userid = loginUser.getUserid();
					int sortTypeidString = list.getId();
					TUserSortType usertypeSortType = new TUserSortType();
					usertypeSortType.setUserid(userid);
					usertypeSortType.setSortTypeId(sortTypeidString);
					int results = sdao.addUserSortType(usertypeSortType);
				}else {
					laydata.code = LayuiData.ERRR;
					laydata.msg = "���ʧ��";
				}
				
			}else {
				laydata.code = LayuiData.ERRR;
				laydata.msg = "�������Ѵ���";
			}
			out = response.getWriter();
			out.write(JSON.toJSONString(laydata));
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="getAllSortType")
	public void getAllSortType(HttpServletRequest request, HttpServletResponse response, Model model,
			String userid) throws IOException{
		HttpSession session = request.getSession();
		TUser loginUser  = (TUser)session.getAttribute("loginuser");
		List<VSortType> list = sdao.getAllSortType(loginUser.getUserid());
		if(list!=null&&list.size()>0){
			laydata.code = LayuiData.SUCCESS;
			laydata.msg = "ִ�гɹ�";
			laydata.data = list;
		} else {
			laydata.code = LayuiData.ERRR;
			laydata.msg = "������";
		}
		out = response.getWriter();
		out.write(JSON.toJSONString(laydata));
		out.flush();
		out.close();
	}
	
	@RequestMapping(value="/updateSortType")
	public void UpdateSortType(
			int id,
			String sortname,
			int types,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException{

		//�ش�json�ַ���
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		LayuiTableData td = new LayuiTableData();//layui��json����ֵ������
		
		HttpSession session = request.getSession();
		TUser loginUser  = (TUser)session.getAttribute("loginuser");
		List<VSortType> list = sdao.getAllSortType(loginUser.getUserid());
		TSortType sorttype = sdao.getTSortTypeById(id);//��ѯ�Ƿ�����ʹ���
		if (sortname!="" && sortname!=null && !sortname.equals("") && types!=0) {
			if (sorttype != null && !sorttype.equals("")) {
				sorttype.setId(id);;
				sorttype.setPhotoid(list.get(0).getPhotoid());
				sorttype.setSortname(sortname);
				sorttype.setTypes(types);
				
				if (sdao.updateSortType(sorttype)) {
					td.code = LayuiTableData.FLAG_SUCC;
					td.msg = "�޸ĳɹ�";
				}else {
					td.code = LayuiTableData.FLAG_FAIL;
					td.msg = "�޸�ʧ��";
				}
				
			}else {
				td.code = LayuiTableData.FLAG_FAIL;
				td.msg = "�����Ͳ�����";
			}
			
		}else {
			td.code = LayuiTableData.FLAG_FAIL;
			td.msg = "�޸�ʧ��";
		}
		out.write(JSON.toJSONString(td));
		out.flush();
		out.close();
	}
	
	@RequestMapping(value="/deleteSortType")
	public void DeleteSortType(
			int id,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		
		
		//�ش�json�ַ���
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		LayuiTableData td = new LayuiTableData();//layui��json����ֵ������
	
		if (id < 0 ) {
			td.code = LayuiTableData.FLAG_FAIL;
			td.msg = "���󲻴��ڣ�ɾ��ʧ��";
		}
			
		//�ش�json�ַ���
		if(sdao.deleteSortType(id)){
			td.code = LayuiTableData.FLAG_SUCC;
			td.msg = "ɾ���ɹ�";
		}else{
			td.code = LayuiTableData.FLAG_FAIL;
			td.msg = "��ѯʧ��";
		}
		out.write(JSON.toJSONString(td));
		out.flush();
		out.close();
	}
}
