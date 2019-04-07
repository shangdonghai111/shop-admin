package com.fh.shop.backend.mapper.member;

import com.fh.shop.backend.po.member.Member;

import java.util.List;

public interface MemberMapper {
    List<Member> queryMemberList();

    Member findOne(Integer id);


    void update(Member member);
}
