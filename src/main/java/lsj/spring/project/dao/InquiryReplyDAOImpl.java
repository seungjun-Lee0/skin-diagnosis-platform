package lsj.spring.project.dao;

import lsj.spring.project.vo.InquiryReply;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("irdao")
public class InquiryReplyDAOImpl implements InquiryReplyDAO{

    @Autowired private SqlSession sqlSession;

    @Override
    public List<InquiryReply> selectReply(String bno) {
        return sqlSession.selectList("reply.selectReply",bno);
    }

    @Override
    public int insertComment(InquiryReply ir) {
        return sqlSession.insert("reply.insertComment", ir);
    }

    @Override
    public int updateComment(InquiryReply ir) {
        return sqlSession.update("reply.updateComment", ir);
    }

    @Override
    public int deleteComment(InquiryReply ir) {
        return sqlSession.delete("reply.deleteComment", ir);
    }

    @Override
    public int countComment(String bno) {
        return sqlSession.selectOne("reply.countComment", bno);
    }


}
