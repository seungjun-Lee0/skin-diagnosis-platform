package lsj.spring.project.utils;

import org.imgscalr.Scalr;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.Date;

@Component("imgutil")
public class ImgUploadUtil {

    //private String uploadPath = "C:\\Users\\USER\\IdeaProjects\\the3.0-dermatology-hospital-website\\src\\main\\webapp\\resources\\images\\downloadedImages\\";
    private String uploadPath = "/opt/tomcat/apache-tomcat-8.5.75/webapps/SemiProjectV3-1.0-SNAPSHOT/resources/images/downloadedImages/";
    //private String uploadPath2 = "C:\\Users\\USER\\Desktop\\acne_detect\\dist\\acne_detect\\test\\";
    private String uploadPath2 = "/opt/tomcat/acne_detect/dist/acne_detect/test/";

    public boolean checkFiles(MultipartFile[] img) {
        boolean isFiles = false;
        for(MultipartFile f : img) {
            if(!f.getOriginalFilename().isEmpty()) {
                isFiles = true;
                break;
            }
        }
        return isFiles;
    }

    public String ImageUpload(MultipartFile f, String uuid, String dir) {
        String ofname = f.getOriginalFilename();

        int pos = ofname.lastIndexOf(".");
        String nfame = ofname.substring(0, pos) + uuid + "." +
                ofname.substring(pos+1);

        try {
            f.transferTo(new File(uploadPath + dir + nfame));
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return ofname;
    }

    public String ImageUpload2(MultipartFile f, String uuid) {
        String ofname = f.getOriginalFilename();

        int pos = ofname.lastIndexOf(".");
        String nfame = uuid + "." + ofname.substring(pos+1);
        //File file = new File(uploadPath + "diagnosis\\" + nfame);
        File file = new File(uploadPath + "diagnosis/" + nfame);
        File nfile = new File(uploadPath2 + nfame);
        try {
            f.transferTo(file);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        try {
            Files.copy(file.toPath(), nfile.toPath(), StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException ex){
            ex.printStackTrace();
        }
        return ofname;
    }

    public String ImageUpload(MultipartFile f, String uuid, String dir, int width, int height) {
        String ofname = f.getOriginalFilename();

        try{
            BufferedImage image = ImageIO.read(f.getInputStream());

            Image resizedImage = image.getScaledInstance(width, height, Image.SCALE_DEFAULT);
            BufferedImage newImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            Graphics graphics = newImage.getGraphics();
            graphics.drawImage(resizedImage, 0, 0, null);
            graphics.dispose();

        int pos = ofname.lastIndexOf(".");
        String nftype = ofname.substring(pos+1);
        String nfname = ofname.substring(0, pos) + uuid + "." + nftype;

        ImageIO.write(newImage,nftype, new File(uploadPath + dir + nfname));
        }catch (Exception ex) {
            ex.printStackTrace();
        }

        return ofname;
    }

    public String makeUUID() {
        String fmt = "yyyyMMddHHmmss";
        SimpleDateFormat sdf = new SimpleDateFormat(fmt);

        return sdf.format(new Date());
    }
}
