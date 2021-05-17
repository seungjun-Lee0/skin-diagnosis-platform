package lsj.spring.project.service;

import lsj.spring.project.vo.Member;

import javax.servlet.http.HttpSession;

public interface MemberService {

    void newMember(Member m) throws Exception;
    String checkUserid(String uid);
    String checkUserid2(Member m);
    String checkUemail(String uemail);
    boolean findUserid(Member m);
    boolean checkLogin(Member m, HttpSession sess) throws Exception;
    String updateUserpwd(Member m) throws Exception;
    Member readOneMember(String uid);
    void modifyMember(Member m, HttpSession sess) throws Exception;
    void removeMember(Member m);

}
