package lsj.spring.project.dao;

import lsj.spring.project.vo.Inquiry;
import lsj.spring.project.vo.Notice;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("idao")
public class InquiryDAOImpl implements InquiryDAO{

    @Autowired private SqlSession sqlSession;

    @Override
    public int insertInquiry(Inquiry iq) {
        return sqlSession.insert("inquiry.insertInquiry", iq);
    }

    @Override
    public List<Inquiry> selectInquiry(int snum) {
        return sqlSession.selectList("inquiry.selectInquiry", snum);
    }

    @Override
    public List<Inquiry> selectInquiry(int snum, String uid) {
        Map<String, Object> params = new HashMap<>();
        params.put("snum", snum);
        params.put("uid", uid);
        return sqlSession.selectList("inquiry.selectInquiryByUid", params);
    }

    @Override
    public List<Inquiry> selectAllInquiry() {
        return sqlSession.selectList("inquiry.selectInquiryAll");
    }

    @Override
    public List<Inquiry> findSelectInquiry(Map<String, Object> param) {
        return sqlSession.selectList("inquiry.findSelect", param);
    }

    @Override
    public Inquiry selectOneInquiry(String bno) {
        return sqlSession.selectOne("inquiry.selectOne", bno);
    }

    @Override
    public int selectCountInquiry() {
        return sqlSession.selectOne("inquiry.countInquiry");
    }

    @Override
    public int selectCountInquiryByUid(String uid) {
        return sqlSession.selectOne("inquiry.countInquiryByUid", uid);
    }

    @Override
    public int checkSecretInquiry(String bno, String pwd){
        Map<String, Object> params = new HashMap<>();
        params.put("bno", bno);
        params.put("pwd", pwd);
        return  sqlSession.selectOne("inquiry.checkPwd",params);
    }

    @Override
    public int selectCountInquiry(Map<String, Object> param) {
        return sqlSession.selectOne("inquiry.findSelectCount", param);
    }

    @Override
    public int viewCountInquiry(String bno) {
        return sqlSession.update("inquiry.viewInquiry", bno);
    }

    @Override
    public String readFnames(String bno) {
        return sqlSession.selectOne("inquiry.readFnames", bno);
    }

    @Override
    public String readUuid(String bno) {
        return sqlSession.selectOne("inquiry.readUuid", bno);
    }

    @Override
    public void updateComment(int bno, int countComment) {
        Map<String, Object> params = new HashMap<>();
        params.put("bno", bno);
        params.put("comment", countComment);

        sqlSession.update("inquiry.updateComment", params);
    }

    @Override
    public void updateStatus(String bno) {
        sqlSession.update("inquiry.updateStatus", bno);
    }

    @Override
    public int modifyInquiry(Inquiry iq) {
        return sqlSession.update("inquiry.modifyInquiry", iq);
    }

    @Override
    public int deleteInquiry(String bno) {
        System.out.println(bno + "wtf");
        return sqlSession.delete("inquiry.deleteInquiry", Integer.parseInt(bno));
    }
}
