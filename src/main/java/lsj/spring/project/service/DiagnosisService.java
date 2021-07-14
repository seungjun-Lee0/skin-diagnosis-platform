package lsj.spring.project.service;

import lsj.spring.project.vo.Acne;
import lsj.spring.project.vo.Diagnosis;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface DiagnosisService {
    void newDiagnosis1(Diagnosis d);
    String readOneDno(String uid);
    void newDiagnosis2(Diagnosis d, MultipartFile[] img);

    List<Diagnosis> readDiagnosis(String cp);
    List<Diagnosis> readDiagnosis(String cp, String ftype, String fkey);

    int countDiagnosis();
    int countDiagnosis(String ftype, String fkey);

    Diagnosis readOneDiagnosis(String dno);
    void newAcneScore(Acne a);
    Acne readAcneScore(String uid);
}
