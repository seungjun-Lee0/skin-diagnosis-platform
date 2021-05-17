package lsj.spring.project.dao;

import lsj.spring.project.vo.Member;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository("mbdao")
public class MemberDAOImpl implements MemberDAO{

    @Autowired private SqlSession sqlSession;

    @Override
    public int insertMember(Member m) {
        return sqlSession.insert("member.insertMember", m);
    }

    @Override
    public int selectOneUserid(String uid) {
        return sqlSession.selectOne("member.selectOneUserid", uid);
    }

    @Override
    public int selectOneUserid2(Member m) {
        return sqlSession.selectOne("member.selectOneUserid2", m);
    }

    @Override
    public int selectOneUemail(String uemail) {
        return sqlSession.selectOne("member.selectOneUemail", uemail);
    }

    @Override
    public String findOneUserid(Member m) {
        return sqlSession.selectOne("member.findOneUserid", m);
    }

    @Override
    public void updateUserpwd(Member m) { sqlSession.update("member.updateUserpwd", m); }
    @Override
    public int selectLogin(Map<String, Object> param) {
        return sqlSession.selectOne("member.selectLogin", param);
    }

    @Override
    public String selectSalt(String uid) { return sqlSession.selectOne("member.selectSalt", uid);}

    @Override
    public Member showOneMember(String uid) {
        return sqlSession.selectOne("member.showOneMember", uid);
    }

    @Override
    public int updateMember(Map<String, Object> param) {
        return sqlSession.update("member.updateMember", param);
    }

    @Override
    public void deleteMember(Member m) {
        sqlSession.delete("member.deleteMember", m);
    }
}
