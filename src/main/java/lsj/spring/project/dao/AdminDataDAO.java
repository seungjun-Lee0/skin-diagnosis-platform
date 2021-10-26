package lsj.spring.project.dao;

import lsj.spring.project.vo.AdminData;

import java.util.List;
import java.util.Map;

public interface AdminDataDAO {

    int insertAdminDataLog(AdminData ad);
    int insertAdminDataCureV(AdminData ad);
    int insertAdminDataCureI(AdminData ad);
    int insertAdminDataCureT(AdminData ad);
    int insertAdminDataCureL(AdminData ad);

    List<AdminData> selectAdminData(int snum);
    List<AdminData> SelectAdminData(Map<String, Object> params);
    List<AdminData> selectAllAdminData();

    AdminData selectOneAdminData(String adno);

    int selectCountAdminData();
    int selectCountAdminData(Map<String, Object> params);

    int deleteAdminInquiry(String adno);
}
