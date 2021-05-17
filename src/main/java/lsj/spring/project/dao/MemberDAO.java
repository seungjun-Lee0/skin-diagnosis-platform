package lsj.spring.project.dao;

import lsj.spring.project.vo.Member;

import java.util.Map;

public interface MemberDAO {

    int insertMember(Member m);
    int selectOneUserid(String uid);
    int selectOneUserid2(Member m);
    int selectOneUemail(String uemail);
    String findOneUserid(Member m);
    void updateUserpwd(Member m);
    int selectLogin(Map<String, Object> param);
    String selectSalt(String uid);

    Member showOneMember(String uid);

    int updateMember(Map<String, Object> param);
    void deleteMember(Member m);
}
