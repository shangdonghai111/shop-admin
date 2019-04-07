package com.fh.shop.backend;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class Demo1 {
    public static void main(String[] args) {
        //创建workbook *.xlsx
        XSSFWorkbook workbook = new XSSFWorkbook();
        //创建sheet
        XSSFSheet sheet = workbook.createSheet("学生表");
        //创建行
        XSSFRow titleRow = sheet.createRow(0);
        //创建列/单元格
        XSSFCell stuNameCell = titleRow.createCell(0);
        //给单元格赋值
        stuNameCell.setCellValue("学生名");
        //创建列/单元格
        XSSFCell stuAgeCell = titleRow.createCell(1);
        //给单元格赋值
        stuAgeCell.setCellValue("学生年龄");
        //创建内容
        XSSFRow row1 = sheet.createRow(1);
        XSSFCell stuNameCell1 = row1.createCell(0);
        stuNameCell1.setCellValue("张三");
        XSSFCell stuAgeCell1 = row1.createCell(1);
        stuAgeCell1.setCellValue(20);

        XSSFRow row2 = sheet.createRow(2);
        XSSFCell stuNameCell2 = row2.createCell(0);
        stuNameCell2.setCellValue("李四");
        XSSFCell stuAgeCell2 = row2.createCell(1);
        stuAgeCell2.setCellValue(18);
        
        //将workbook写入到硬盘上生成后缀名*.xlsx的文件
        FileOutputStream fileOutputStream=null;
        try {
         fileOutputStream = new FileOutputStream("d:/1808stu.xlsx");
         workbook.write(fileOutputStream);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if(null!=fileOutputStream){
                try {
                    fileOutputStream.close();
                    fileOutputStream=null;
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }


    }
}
