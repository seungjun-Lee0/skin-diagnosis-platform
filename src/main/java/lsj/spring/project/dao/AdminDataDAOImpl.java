package lsj.spring.project.dao;

import lsj.spring.project.vo.AdminData;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("addao")
public class AdminDataDAOImpl implements AdminDataDAO{

    @Autowired private SqlSession sqlSession;

    @Override
    public int insertAdminDataLog(AdminData ad) {
        return sqlSession.insert("adminData.insertAdminDataLog", ad);
    }

    @Override
    public int insertAdminDataCureV(AdminData ad) {
        return sqlSession.insert("adminData.insertAdminDataCureV", ad);
    }

    @Override
    public int insertAdminDataCureI(AdminData ad) {
        return sqlSession.insert("adminData.insertAdminDataCureI", ad);
    }

    @Override
    public int insertAdminDataCureT(AdminData ad) {
        return sqlSession.insert("adminData.insertAdminDataCureT", ad);
    }

    @Override
    public int insertAdminDataCureL(AdminData ad) {
        return sqlSession.insert("adminData.insertAdminDataCureL", ad);
    }

    @Override
    public List<AdminData> selectAdminData(int snum) {
        return sqlSession.selectList("adminData.selectAdminData", snum);
    }

    @Override
    public List<AdminData> SelectAdminData(Map<String, Object> params) {
        return sqlSession.selectList("adminData.findSelectAdminData", params);
    }

    @Override
    public List<AdminData> selectAllAdminData() {
        return sqlSession.selectList("adminData.selectAllAdminData");
    }

    @Override
    public AdminData selectOneAdminData(String adno) {
        return sqlSession.selectOne("adminData.selectOneAdminData", adno);
    }

    @Override
    public int selectCountAdminData() {
        return sqlSession.selectOne("adminData.selectCountAdminData");
    }

    @Override
    public int selectCountAdminData(Map<String, Object> params) {
        return sqlSession.selectOne("adminData.findSelectCountAdminData", params);
    }

    @Override
    public int deleteAdminInquiry(String adno) {
        return sqlSession.delete("adminData.deleteAdminInquiry", Integer.parseInt(adno));
    }
}
