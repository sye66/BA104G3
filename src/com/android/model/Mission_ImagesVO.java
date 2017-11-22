package com.android.model;

import java.io.Serializable;

/**
 * Created by Java on 2017/11/1.
 */

public class Mission_ImagesVO implements Serializable{
    private String image_No;
    private String mission_No;
    private String issuer_Mem_No;
    private byte[] issuer_Images;



    public String getImage_No() {
        return image_No;
    }

    public void setImage_No(String image_No) {
        this.image_No = image_No;
    }

    public String getMission_No() {
        return mission_No;
    }

    public void setMission_No(String mission_No) {
        this.mission_No = mission_No;
    }

    public String getIssuer_Mem_No() {
        return issuer_Mem_No;
    }

    public void setIssuer_Mem_No(String issuer_Mem_No) {
        this.issuer_Mem_No = issuer_Mem_No;
    }

    public byte[] getIssuer_Images() {
        return issuer_Images;
    }

    public void setIssuer_Images(byte[] issuer_Images) {
        this.issuer_Images = issuer_Images;
    }
}
