package com.fh.shop.backend.biz.member;

import com.fh.shop.backend.mapper.member.MemberMapper;
import com.fh.shop.backend.po.member.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("memberService")
public class IMemberServiceImpl implements IMemberService{
    @Autowired
    private MemberMapper memberMapper;
    @Override
    public List<Member> queryMemberList() {
        List<Member> queryMemberList = memberMapper.queryMemberList();
        return queryMemberList;
    }

    @Override
    public Member findOne(Integer id) {
        Member one = memberMapper.findOne(id);
        return one;
    }

    @Override
    public void update(Member member) {
        memberMapper.update(member);
    }


}
