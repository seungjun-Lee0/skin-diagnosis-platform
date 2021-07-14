package lsj.spring.project.dao;

import lsj.spring.project.vo.Acne;
import lsj.spring.project.vo.Diagnosis;

import java.util.List;
import java.util.Map;

public interface DiagnosisDAO {

    int insertDiagnosis1(Diagnosis d);
    String selectOneDno(String uid);
    int insertDiagnosis2(Diagnosis d);

    List<Diagnosis> selectDiagnosis(int snum);
    List<Diagnosis> findSelectDiagnosis(Map<String, Object> params);

    int selectCountDiagnosis();
    int selectCountDiagnosis(Map<String, Object> params);

    Diagnosis selectOneDiagnosis(String dno);

    int insertAcneScore(Acne a);
    Acne selectAcneScore(String uid);
}
