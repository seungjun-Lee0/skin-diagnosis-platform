package lsj.spring.project.service;

import lsj.spring.project.dao.AdminDataDAO;
import lsj.spring.project.vo.AdminData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("adsrv")
public class AdminDataServiceImpl implements AdminDataService{

    @Autowired private AdminDataDAO addao;

    @Override
    public void newAdminDataLog(AdminData ad) {
        addao.insertAdminDataLog(ad);
    }

    @Override
    public void newAdminDataCureV(AdminData ad) {
        addao.insertAdminDataCureV(ad);
    }

    @Override
    public void newAdminDataCureI(AdminData ad) {
        addao.insertAdminDataCureI(ad);
    }

    @Override
    public void newAdminDataCureT(AdminData ad) {
        addao.insertAdminDataCureT(ad);
    }

    @Override
    public void newAdminDataCureL(AdminData ad) {
        addao.insertAdminDataCureL(ad);
    }

    @Override
    public List<AdminData> readAdminData(String cp) {
        int snum = 10 * (Integer.parseInt(cp) - 1);
        return addao.selectAdminData(snum);
    }

    @Override
    public List<AdminData> readAdminData(String cp, String fkey1, String fkey2) {
        int snum = 10 * (Integer.parseInt(cp) - 1);

        Map<String, Object> params = new HashMap<>();
        params.put("snum", snum);
        params.put("fkey1", fkey1);
        params.put("fkey2", fkey2);
        return addao.SelectAdminData(params);
    }

    @Override
    public List<AdminData> readAllAdminData() {
        return addao.selectAllAdminData();
    }

    @Override
    public AdminData readOneAdminData(String adno) {
        return addao.selectOneAdminData(adno);
    }

    @Override
    public int countAdminData() {
        return addao.selectCountAdminData();
    }

    @Override
    public int countAdminData(String fkey1, String fkey2) {
        Map<String, Object> params = new HashMap<>();
        params.put("fkey1", fkey1);
        params.put("fkey2", fkey2);

        return addao.selectCountAdminData(params);
    }

    @Override
    public void deleteAdminInquiry(String adno) {
        addao.deleteAdminInquiry(adno);
    }
}
