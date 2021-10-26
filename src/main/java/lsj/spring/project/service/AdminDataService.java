package lsj.spring.project.service;

import lsj.spring.project.vo.AdminData;

import java.util.List;

public interface AdminDataService {
    void newAdminDataLog(AdminData a);
    void newAdminDataCureV(AdminData a);
    void newAdminDataCureI(AdminData a);
    void newAdminDataCureT(AdminData a);
    void newAdminDataCureL(AdminData a);

    List<AdminData> readAdminData(String cp);
    List<AdminData> readAdminData(String cp, String fkey1, String fkey2);
    List<AdminData> readAllAdminData();
    AdminData readOneAdminData(String adno);

    int countAdminData();
    int countAdminData(String fkey1, String fkey2);

    void deleteAdminInquiry(String adno);
}
