package com.fh.shop.backend.biz.member;

import com.fh.shop.backend.po.member.Member;

import java.util.List;

public interface IMemberService {

    List<Member> queryMemberList();

    Member findOne(Integer id);


    void update(Member member);
}
