package lsj.spring.project.service;

import lsj.spring.project.dao.MemberDAO;
import lsj.spring.project.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Service("mbsrv")
public class MemberServiceImpl implements MemberService{
    private static final int SALT_SIZE = 16;

    @Autowired private MemberDAO mbdao;


    @Override
    public void newMember(Member m) throws Exception {
        String SALT = getSALT();

        m.setUpwd(Hashing(m.getUpwd().getBytes(),SALT));
        m.setSalt(SALT);
        mbdao.insertMember(m);
    }

    private String Hashing(byte[] password, String Salt) throws Exception {

        MessageDigest md = MessageDigest.getInstance("SHA-256");	// use hash function SHA-256

        // key-stretching
        for(int i = 0; i < 10000; i++) {
            String temp = Byte_to_String(password) + Salt;	// create new string object by combining password and salt
            md.update(temp.getBytes());						// save the hashed string object into md
            password = md.digest();							// completes the hash computation and update it as a password
        }

        return Byte_to_String(password);
    }

    // create the SALT value
    private String getSALT() {
        SecureRandom rnd = new SecureRandom();
        byte[] temp = new byte[SALT_SIZE];
        rnd.nextBytes(temp);

        return Byte_to_String(temp);

    }

    // alter the byte value as hexadecimal number
    private String Byte_to_String(byte[] temp) {
        StringBuilder sb = new StringBuilder();
        for(byte a : temp) {
            sb.append(String.format("%02x", a));
        }
        return sb.toString();
    }

    @Override
    public String checkUserid(String uid) {
        return mbdao.selectOneUserid(uid)+"";
    }

    @Override
    public String checkUserid2(Member m) {return  mbdao.selectOneUserid2(m)+""; }

    @Override
    public String checkUemail(String uemail) {
        return mbdao.selectOneUemail(uemail)+"";
    }

    @Override
    public boolean findUserid(Member m) {
        boolean status = false;
        if(mbdao.findOneUserid(m) != null){
            m.setUid(mbdao.findOneUserid(m));
            status = true;
        }
        return status;
    }

    public String GeneratePwd(){
        int leftLimit = 48; // numeral '0'
        int rightLimit = 122; // letter 'z'
        int targetStringLength = 10;
        Random random = new Random();

        String generatedPwd = random.ints(leftLimit,rightLimit + 1)
                .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
                .limit(targetStringLength)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();

        return generatedPwd;
    }

    @Override
    public String updateUserpwd(Member m) throws Exception {
        String SALT = getSALT();
        String temp_pwd = GeneratePwd();

        m.setUpwd(Hashing(temp_pwd.getBytes(),SALT));
        m.setSalt(SALT);
        mbdao.updateUserpwd(m);
        return temp_pwd;
    }

    @Override
    public boolean checkLogin(Member m, HttpSession sess) throws Exception {
        boolean isLogIn = false;

        String temp_salt = mbdao.selectSalt(m.getUid());
        String temp_pass = Hashing(m.getUpwd().getBytes(), temp_salt);
        Map<String, Object> params = new HashMap<>();
        params.put("uid", m.getUid());
        params.put("upwd", temp_pass);
        params.put("salt", temp_salt);

        if(mbdao.selectLogin(params) > 0){
            sess.setAttribute("MyInfo", readOneMember(m.getUid()));
            isLogIn = true;
        }
        return isLogIn;
    }


    @Override
    public Member readOneMember(String uid) {
        return mbdao.showOneMember(uid);
    }

    @Override
    public void modifyMember(Member m, HttpSession sess) throws Exception {

        String SALT = getSALT();
        m.setUpwd(Hashing(m.getUpwd().getBytes(),SALT));
        m.setSalt(SALT);
        Map<String, Object> params = new HashMap<>();
        params.put("uid", m.getUid());
        params.put("upwd", m.getUpwd());
        params.put("salt", m.getSalt());
        params.put("uemail", m.getUemail());
        params.put("utel", m.getUtel());
        params.put("mail", m.getMail());
        params.put("sms", m.getSms());


       if (mbdao.updateMember(params) > 0) {
           sess.setAttribute("MyInfo", readOneMember(m.getUid()));
       }
    }

    @Override
    public void removeMember(Member m) {
        mbdao.deleteMember(m);
    }
}
