package com.fh.shop.backend.controller.member;

import com.fh.shop.backend.biz.member.IMemberService;
import com.fh.shop.backend.common.ServerResponse;
import com.fh.shop.backend.po.member.Member;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("member")
public class MemberController {
    @Resource(name = "memberService")
    private IMemberService memberService;


    @RequestMapping(value = "toMemberList")
    public String toMemberList(){
        return "member/memberList";
    }
    /**
    * @Description:    查询所有
    * @Author:         ShangDongHai q540662261@126.com
    * @CreateDate:     2019/3/20 20:28
    * @UpdateUser:     Shangdonghai
    * @UpdateDate:     2019/3/20 20:28
    * @UpdateRemark:   修改内容
    * @Version:        1.0
    */
    @RequestMapping(value = "queryMemberList",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse queryMemberList(){
        List<Member>list=memberService.queryMemberList();
        return ServerResponse.success(list);
    }
    /**
    * @Description:    回显
    * @Author:         ShangDongHai q540662261@126.com
    * @CreateDate:     2019/3/20 20:28
    * @UpdateUser:     Shangdonghai
    * @UpdateDate:     2019/3/20 20:28
    * @UpdateRemark:   修改内容
    * @Version:        1.0
    */
    @RequestMapping("findOne")
    public ModelAndView findOne(Integer id){
        ModelAndView modelAndView = new ModelAndView("/member/updateMember");
        Member member=memberService.findOne(id);
        modelAndView.addObject("member",member);
        return modelAndView;
    }
    /**
    * @Description:    修改
    * @Author:         ShangDongHai q540662261@126.com
    * @CreateDate:     2019/3/20 21:09
    * @UpdateUser:     Shangdonghai
    * @UpdateDate:     2019/3/20 21:09
    * @UpdateRemark:   修改内容
    * @Version:        1.0
    */
    @RequestMapping("update")
    public String update(Member member){
        memberService.update(member);
        return "redirect:toMemberList.jhtml";
    }
}
