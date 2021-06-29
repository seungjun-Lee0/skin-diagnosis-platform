package lsj.spring.project.dao;

import lsj.spring.project.vo.Notice;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("ndao")
public class NoticeDAOImpl implements NoticeDAO{

    @Autowired private SqlSession sqlSession;

    @Override
    public int insertNotice(Notice n) { return sqlSession.insert("notice.insertNotice", n); }

    @Override
    public List<Notice> selectNotice(int snum) {
        return sqlSession.selectList("notice.selectNotice", snum);
    }

    @Override
    public List<Notice> selectAllNotice() {
        return sqlSession.selectList("notice.selectNoticeAll");
    }

    @Override
    public List<Notice> findSelectNotice(Map<String, Object> param) {
        return sqlSession.selectList("notice.findSelect", param);
    }

    @Override
    public Notice selectOneNotice(String bno) {
        return sqlSession.selectOne("notice.selectOne", bno);
    }

    @Override
    public int selectCountNotice() {
        return sqlSession.selectOne("notice.countNotice");
    }

    @Override
    public int selectCountNotice(Map<String, Object> param) {
        return sqlSession.selectOne("notice.findSelectCount", param);
    }

    @Override
    public int viewCountNotice(String bno) {
        return sqlSession.update("notice.viewNotice", bno);
    }

    @Override
    public String readFnames(String bno) {
        return sqlSession.selectOne("notice.readFnames", bno);
    }

    @Override
    public String readUuid(String bno) {
        return sqlSession.selectOne("notice.readUuid", bno);
    }

    @Override
    public int modifyNotice(Notice n) {
        return sqlSession.update("notice.modifyNotice", n);
    }

    @Override
    public int deleteNotice(String bno) {
        return sqlSession.delete("notice.deleteNotice", Integer.parseInt(bno));
    }
}
