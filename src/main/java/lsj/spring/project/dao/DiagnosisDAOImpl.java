package lsj.spring.project.dao;

import lsj.spring.project.vo.Acne;
import lsj.spring.project.vo.Diagnosis;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("dgdao")
public class DiagnosisDAOImpl implements DiagnosisDAO{

    @Autowired private SqlSession sqlSession;

    @Override
    public int insertDiagnosis1(Diagnosis d) {
        return sqlSession.insert("diagnosis.insertDiagnosis1", d);
    }

    @Override
    public String selectOneDno(String uid) {
        return sqlSession.selectOne("diagnosis.selectOneDno", uid);
    }

    @Override
    public int insertDiagnosis2(Diagnosis d) {
        return sqlSession.update("diagnosis.insertDiagnosis2", d);
    }

    @Override
    public List<Diagnosis> selectDiagnosis(int snum) {
        return sqlSession.selectList("diagnosis.selectDiagnosis", snum);
    }

    @Override
    public List<Diagnosis> findSelectDiagnosis(Map<String, Object> params) {
        return sqlSession.selectList("diagnosis.findSelect", params);
    }

    @Override
    public int selectCountDiagnosis() {
        return sqlSession.selectOne("diagnosis.countDiagnosis");
    }

    @Override
    public int selectCountDiagnosis(Map<String, Object> params) {
        return sqlSession.selectOne("diagnosis.findSelectCount", params);
    }

    @Override
    public Diagnosis selectOneDiagnosis(String dno) {
        return sqlSession.selectOne("diagnosis.selectOne", dno);
    }

    @Override
    public int insertAcneScore(Acne a) {
        return sqlSession.insert("diagnosis.insertAcneScore", a);
    }

    @Override
    public Acne selectAcneScore(String uid) {
        return sqlSession.selectOne("diagnosis.selectAcneResult", uid);
    }
}
