package com.fh.shop.backend.controller.product;

import com.fh.shop.backend.annotation.LogAnnotation;
import com.fh.shop.backend.biz.brand.BrandService;
import com.fh.shop.backend.biz.images.ImagesService;
import com.fh.shop.backend.biz.product.IProductService;
import com.fh.shop.backend.common.DataTableResult;
import com.fh.shop.backend.common.ServerResponse;
import com.fh.shop.backend.controller.BaseController;
import com.fh.shop.backend.gloable.Gloable;
import com.fh.shop.backend.po.brand.Brand;
import com.fh.shop.backend.po.images.Images;
import com.fh.shop.backend.po.product.Product;
import com.fh.shop.backend.util.FileUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("product")
public class ProductController extends BaseController {
    //声明日志 导org.slf4j.Logger的包
    private static final Logger LOG = LoggerFactory.getLogger(ProductController.class);
    //引入业务层
    @Autowired
    private IProductService proSer;
    //引入品牌service层
    @Autowired
    private BrandService brandService;
    @Resource
    private ImagesService imagesService;

    /**
     * @Description: poi导出
     * @Author: ShangDongHai q540662261@126.com
     * @CreateDate: 2019/2/15 20:23
     * @UpdateUser: Shangdonghai
     * @UpdateDate: 2019/2/15 20:23
     * @UpdateRemark: 修改内容
     * @Version: 1.0
     */
    @RequestMapping("exportExcel")
    public void exportExcel(Product product, HttpServletResponse response) {
        //查询符合条件的数据
        List<Product> productList = proSer.findProductList(product);
        XSSFWorkbook workbook = buildWorkBook(productList);
        //调用下载工具类进行下载
        FileUtil.excelDownload(workbook, response);
    }

    private XSSFWorkbook buildWorkBook(List<Product> productList) {
        //将其转换为workbook
        XSSFWorkbook workbook = new XSSFWorkbook();
        buildSheet(productList, workbook);
        return workbook;
    }

    private void buildSheet(List<Product> productList, XSSFWorkbook workbook) {
        XSSFSheet sheet = workbook.createSheet("产品表");
        //表头样式
        buildTitleStyle(workbook, sheet);
        //创建标题
        buildHeader(sheet, workbook);
        //创建主体
        buildBody(productList, sheet, workbook);
    }

    private void buildTitleStyle(XSSFWorkbook workbook, XSSFSheet sheet) {
        //标题字体
        XSSFFont titleFont = workbook.createFont();
        titleFont.setBold(true);//字体加粗
        //titleFont.setColor(HSSFColor.GREEN.index);
        titleFont.setColor(new XSSFColor(Color.red));//字体颜色
        titleFont.setFontHeight(28);//字体大小
        //标题样式
        XSSFCellStyle titleStyle = workbook.createCellStyle();
        titleStyle.setAlignment(HorizontalAlignment.CENTER);//水平居中
        titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);//垂直居中
        titleStyle.setFont(titleFont);
        titleStyle.setFillForegroundColor(new XSSFColor(Color.green));
        titleStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
        //构建大标题
        XSSFRow title = sheet.createRow(5);
        XSSFCell cell = title.createCell(6);
        cell.setCellValue("商品列表");
        cell.setCellStyle(titleStyle);
        //合并单元格
        CellRangeAddress cellRangeAddress = new CellRangeAddress(5, 7, 6, 10);
        sheet.addMergedRegion(cellRangeAddress);
    }

    private void buildBody(List<Product> productList, XSSFSheet sheet, XSSFWorkbook workbook) {
        int startRow = 9;
        int startCell = 5;
        //设置格式
        XSSFCellStyle DateStyle = workbook.createCellStyle();
        DateStyle.setDataFormat(workbook.createDataFormat().getFormat("yyyy-MM-dd HH:mm:ss"));

        XSSFCellStyle DateStyleColor = workbook.createCellStyle();
        DateStyleColor.setDataFormat(workbook.createDataFormat().getFormat("yyyy-MM-dd HH:mm:ss"));
        DateStyleColor.setFillForegroundColor(new XSSFColor(Color.red));
        DateStyleColor.setFillPattern(CellStyle.SOLID_FOREGROUND);

        XSSFCellStyle bgcolorStyle = workbook.createCellStyle();
        bgcolorStyle.setFillForegroundColor(new XSSFColor(Color.red));
        bgcolorStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);


        for (int i = 0; i < productList.size(); i++) {
            Product productInfo = productList.get(i);
            XSSFRow row = sheet.createRow(i + startRow);
            XSSFCell pNameCell = row.createCell(startCell + 1);
            pNameCell.setCellValue(productInfo.getProductName());
            XSSFCell priceCell = row.createCell(startCell + 2);
            priceCell.setCellValue(productInfo.getProductPrice());
            XSSFCell pinpainame = row.createCell(startCell + 3);
            pinpainame.setCellValue(productInfo.getBrand().getBrandName());
            XSSFCell insertDate = row.createCell(startCell + 4);
            insertDate.setCellValue(productInfo.getEntrtyTime());
            XSSFCell updateDate = row.createCell(startCell + 5);
            updateDate.setCellValue(productInfo.getUpdateTime());
            if (productInfo.getProductPrice() < 100) {
                pNameCell.setCellStyle(bgcolorStyle);
                priceCell.setCellStyle(bgcolorStyle);
                pinpainame.setCellStyle(bgcolorStyle);
                insertDate.setCellStyle(DateStyleColor);
                updateDate.setCellStyle(DateStyleColor);
            } else {
                insertDate.setCellStyle(DateStyle);
                updateDate.setCellStyle(DateStyle);
            }

        }
    }

    private void buildHeader(XSSFSheet sheet, XSSFWorkbook workbook) {

        //设置表头样式
        XSSFCellStyle headerStyle = buildHeadStyle(workbook);
        String[] headers = {"产品名字", "产品价格", "品牌名称", "录入时间", "修改时间"};
        XSSFRow row1 = sheet.createRow(8);
        //设置列宽
        sheet.setColumnWidth(9, 20 * 256);
        sheet.setColumnWidth(10, 20 * 256);

        for (int i = 0; i < headers.length; i++) {
            String header = headers[i];
            XSSFCell cell = row1.createCell(i + 6);
            cell.setCellValue(header);
            cell.setCellStyle(headerStyle);
        }
    }

    private XSSFCellStyle buildHeadStyle(XSSFWorkbook workbook) {
        XSSFFont titleFont = workbook.createFont();
        titleFont.setBold(true);//字体加粗

        XSSFCellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setAlignment(HorizontalAlignment.CENTER);//水平居中
        headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);//垂直居中
        headerStyle.setFont(titleFont);
        return headerStyle;
    }

    /**
     * @Description: poi按品牌导出Excel
     * @Author: ShangDongHai q540662261@126.com
     * @CreateDate: 2019/2/16 11:09
     * @UpdateUser: Shangdonghai
     * @UpdateDate: 2019/2/16 11:09
     * @UpdateRemark: 修改内容
     * @Version: 1.0
     */
    @RequestMapping("exportBrandExcel")
    public void exportBrandExcel(Product product, HttpServletResponse response) {
        //查询所有符合条件的数据
        //先获取所有的品牌
        List<Brand> brands = brandService.queryList();
        //创建work
        XSSFWorkbook wb = buildWork(product, brands);
        //下载
        //引用工具类,进行下载
        FileUtil.excelDownload(wb, response);
    }

    private XSSFWorkbook buildWork(Product product, List<Brand> brands) {
        //将数据转换成指定的格式
        XSSFWorkbook wb = new XSSFWorkbook();
        //创建sheet
        buildSheet(product, brands, wb);
        return wb;
    }

    private void buildSheet(Product product, List<Brand> brands, XSSFWorkbook wb) {


        Integer id = product.getBrand().getId();
        for (Brand brand : brands) {
            List<Product> productList = null;
            if (id == -1) {
                //核心代码
                product.getBrand().setId(brand.getId());
                productList = proSer.findProductList(product);
                //product.getBrand().setId(-1);
            } else {
                if (brand.getId() == product.getBrand().getId()) {
                    productList = proSer.findProductList(product);
                } else {
                    productList = new ArrayList<>();
                }
            }

            XSSFSheet sheet = wb.createSheet(brand.getBrandName() + "【" + productList.size() + "】");
            //提取表头
            buildTitle(wb, sheet);
            //提取属性栏
            buildHeader(wb, sheet);
            //提取主体
            buildBody(wb, productList, sheet);

        }
    }

    private void buildBody(XSSFWorkbook wb, List<Product> productList, XSSFSheet sheet) {
        //价格低于99的显示红色格式
        XSSFCellStyle red = wb.createCellStyle();
        red.setDataFormat(wb.createDataFormat().getFormat("yyyy/MM/dd HH:mm:ss"));
        red.setFillForegroundColor(IndexedColors.RED.getIndex());//背景颜色红色
        red.setFillPattern(CellStyle.SOLID_FOREGROUND);

        XSSFCellStyle red1 = wb.createCellStyle();
        red1.setFillForegroundColor(IndexedColors.RED.getIndex());//背景颜色红色
        red1.setFillPattern(CellStyle.SOLID_FOREGROUND);

        //设置时间样式
        XSSFCellStyle style = wb.createCellStyle();
        style.setDataFormat(wb.createDataFormat().getFormat("yyyy/MM/dd HH:mm:ss"));
        for (int i = 0; i < productList.size(); i++) {
            Product productInfo = productList.get(i);
            //内容行
            XSSFRow row = sheet.createRow(i + 6);
            if (productInfo.getProductPrice() < 100) {
                XSSFCell pNameCell = row.createCell(7);
                pNameCell.setCellValue(productInfo.getProductName());
                pNameCell.setCellStyle(red);
                XSSFCell priceCell = row.createCell(8);
                priceCell.setCellValue(productInfo.getProductPrice());
                priceCell.setCellStyle(red1);
                XSSFCell pinpainame = row.createCell(9);
                pinpainame.setCellValue(productInfo.getBrand().getBrandName());
                pinpainame.setCellStyle(red);
                XSSFCell creataTime = row.createCell(10);
                creataTime.setCellValue(productInfo.getEntrtyTime());
                creataTime.setCellStyle(red);
                XSSFCell updateTime = row.createCell(11);
                updateTime.setCellValue(productInfo.getUpdateTime());
                updateTime.setCellStyle(red);
            } else {
                XSSFCell pNameCell = row.createCell(7);
                pNameCell.setCellValue(productInfo.getProductName());
                XSSFCell priceCell = row.createCell(8);
                priceCell.setCellValue(productInfo.getProductPrice());
                XSSFCell pinpainame = row.createCell(9);
                pinpainame.setCellValue(productInfo.getBrand().getBrandName());
                XSSFCell creataTime = row.createCell(10);
                creataTime.setCellValue(productInfo.getEntrtyTime());
                creataTime.setCellStyle(style);
                XSSFCell updateTime = row.createCell(11);
                updateTime.setCellValue(productInfo.getUpdateTime());
                updateTime.setCellStyle(style);
            }
        }
    }

    private void buildHeader(XSSFWorkbook wb, XSSFSheet sheet) {
        //商品属性的格式
        XSSFCellStyle cellStyle = wb.createCellStyle();
        // 对其方式
        cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);// 水平
        cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);// 垂直居中
        // 如何设置字体
        XSSFFont font = wb.createFont();
        font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
        cellStyle.setFont(font);

        XSSFRow row1 = sheet.createRow(5);
        //表头行
        XSSFCell cell = row1.createCell(7);
        cell.setCellStyle(cellStyle);
        cell.setCellValue("产品名字");
        XSSFCell cell1 = row1.createCell(8);
        cell1.setCellValue("产品价格");
        cell1.setCellStyle(cellStyle);
        XSSFCell cell2 = row1.createCell(9);
        cell2.setCellValue("品牌名称");
        cell2.setCellStyle(cellStyle);
        XSSFCell cell3 = row1.createCell(10);
        cell3.setCellValue("录入时间");
        cell3.setCellStyle(cellStyle);
        XSSFCell cell4 = row1.createCell(11);
        cell4.setCellValue("修改时间");
        cell4.setCellStyle(cellStyle);
    }

    private void buildTitle(XSSFWorkbook wb, XSSFSheet sheet) {
        //最上面商品列表的格式
        XSSFCellStyle top = wb.createCellStyle();
        top.setFillForegroundColor(IndexedColors.BRIGHT_GREEN.getIndex());//背景颜色绿色
        top.setFillPattern(CellStyle.SOLID_FOREGROUND);
        // 对其方式
        top.setAlignment(XSSFCellStyle.ALIGN_CENTER);// 水平
        top.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);// 垂直居中
        // 如何设置字体
        XSSFFont font1 = wb.createFont();
        font1.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
        font1.setFontHeight(30);
        font1.setColor(XSSFFont.COLOR_RED);
        top.setFont(font1);
        //合并单元格
        //四个参数firstRow 开始行 lastRow 结束行 firstCol开始列 lastCol结束列
        CellRangeAddress rangeAddress = new CellRangeAddress(2, 4, 7, 11);
        // 合并单元格
        sheet.addMergedRegion(rangeAddress);
        //设置列的宽度，第一个值为列数 列数 从0开始 第二个值为宽度
        sheet.setColumnWidth(10, 20 * 256);
        sheet.setColumnWidth(11, 20 * 256);
        XSSFRow row2 = sheet.createRow(2);
        // 行高
        //row2.setHeightInPoints(50);
        XSSFCell cell5 = row2.createCell(7);
        cell5.setCellValue("商品列表");
        cell5.setCellStyle(top);
    }

    /**
     * @Description: poi按品牌导出Excel
     * @Author: ShangDongHai q540662261@126.com
     * @CreateDate: 2019/2/15 20:24
     * @UpdateUser: Shangdonghai
     * @UpdateDate: 2019/2/15 20:24
     * @UpdateRemark: 修改内容
     * @Version: 1.0
     */
    @RequestMapping("111111exportBrandExcel")
    public void exportBrandExcel(HttpServletResponse response) {
        //先获取品牌的集合
        List<Brand> brandList = brandService.queryList();

        //将数据转换为Excel格式,创建一个工作簿
        XSSFWorkbook workbook = new XSSFWorkbook();
        //字体格式
        XSSFFont font = workbook.createFont();
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

        //增加时间格式
        XSSFCellStyle cellStyle = workbook.createCellStyle();
        cellStyle.setDataFormat(workbook.createDataFormat().getFormat("yyyy/MM/dd HH:mm:ss"));

        XSSFCellStyle style = workbook.createCellStyle();
        style.setAlignment(XSSFCellStyle.ALIGN_CENTER);//水平居中
        style.setFont(font);

        for (int i = 0; i < brandList.size(); i++) {
            //通过集合中的数据获取品牌的id值
            Integer id = brandList.get(i).getId();
            //通过品牌的id值来查找商品个数，即可获取同种品牌的商品个数
            //不可使用分组查询，因为分组查询会得到一串数字，而在循环中我们只需要一种品牌的商品数
            Long totalCount = proSer.queryTotal(id);
            //创建sheet表
            XSSFSheet sheet = workbook.createSheet(brandList.get(i).getBrandName() + "，产品数量：" + totalCount);
            //创建sheet表中的表头
            XSSFRow title = sheet.createRow(0);
            //对表头进行赋值
            XSSFCell nameTitle = title.createCell(0);
            nameTitle.setCellValue("产品名");
            nameTitle.setCellStyle(style);
            XSSFCell priceTitle = title.createCell(1);
            priceTitle.setCellValue("产品价格");
            priceTitle.setCellStyle(style);
            XSSFCell createTime = title.createCell(2);
            createTime.setCellValue("录入时间");
            createTime.setCellStyle(style);
            XSSFCell updateTime = title.createCell(3);
            updateTime.setCellValue("修改时间");
            updateTime.setCellStyle(style);
            XSSFCell brandName = title.createCell(4);
            brandName.setCellValue("品牌名称");
            brandName.setCellStyle(style);

            //通过品牌id查询出相同品牌的商品的集合，以便获取相同品牌的商品数据
            List<Product> productList = proSer.findProductListByBrand(id);
            for (int j = 0; j < productList.size(); j++) {
                //获取list集合中的数据
                Product productInfo = productList.get(j);
                //创建表的行，因为有表头所以第一行被占，需要将 j 变为 j+1
                XSSFRow row = sheet.createRow(j + 1);
                //创建行中的单元格，并将数据放到单元格中
                XSSFCell productNameCell = row.createCell(0);
                productNameCell.setCellValue(productInfo.getProductName());
                XSSFCell priceCell = row.createCell(1);
                priceCell.setCellValue(productInfo.getProductPrice());
                XSSFCell createTimeCell = row.createCell(2);
                createTimeCell.setCellValue(productInfo.getEntrtyTime());
                createTimeCell.setCellStyle(cellStyle);
                XSSFCell updateTimeCell = row.createCell(3);
                updateTimeCell.setCellValue(productInfo.getUpdateTime());
                updateTimeCell.setCellStyle(cellStyle);
                XSSFCell brandNameCell = row.createCell(4);
                brandNameCell.setCellValue(productInfo.getBrand().getBrandName());
            }
        }
        //引用工具类,进行下载
        FileUtil.excelDownload(workbook, response);
    }

    /**
     * <pre>toAdd(跳转至增加页面)
     * 创建人：ShangDongHai q540662261@126.com
     * 创建时间：2018年12月25日 下午5:06:51
     * 修改人：ShangDongHai q540662261@126.com
     * 修改时间：2018年12月25日 下午5:06:51
     * 修改备注：
     * @return</pre>
     */
    @SuppressWarnings("unused")
    @RequestMapping("toAdd")
    public String toAdd(ModelMap map) {
        List<Brand> queryList = brandService.queryList();
        map.put("queryList", queryList);
        return "product/addProduct";
    }

    /**
     * <pre>add(增加的方法)
     * 创建人：ShangDongHai q540662261@126.com
     * 创建时间：2018年12月25日 下午5:07:12
     * 修改人：ShangDongHai q540662261@126.com
     * 修改时间：2018年12月25日 下午5:07:12
     * 修改备注：
     * @return</pre>
     */
    @RequestMapping("add")
    @LogAnnotation("增加商品")
    public String add(Product propuct, HttpServletRequest request, @RequestParam MultipartFile filePath, @RequestParam MultipartFile[] productImagePath) {
        //获取输入流
        if (filePath.getSize() > 0) {
            try {
                InputStream inputStream = filePath.getInputStream();
                //获取文件名
                String originalFilename = filePath.getOriginalFilename();
                //获取真实路径
                String realPath = request.getServletContext().getRealPath(Gloable.SYSTEM_IMAGESPATH);
                String path = FileUtil.copyFile(inputStream, originalFilename, realPath);
                propuct.setProductImage(Gloable.SYSTEM_IMAGESPATH + path);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        proSer.add(propuct);
        if (productImagePath.length > 1) {
            Images images = new Images();
            for (int i = 0; i < productImagePath.length; i++) {
                try {
                    InputStream inputStream = productImagePath[i].getInputStream();
                    //获取文件名
                    String originalFilename = productImagePath[i].getOriginalFilename();
                    //获取真实路径
                    String realPath = request.getServletContext().getRealPath(Gloable.SYSTEM_IMAGESPATH);
                    String path = FileUtil.copyFile(inputStream, originalFilename, realPath);
                    images.setImagePath(Gloable.SYSTEM_IMAGESPATH + path);
                    images.setProductId(propuct.getId());
                    imagesService.add(images);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }
        return "redirect:toProductList.jhtml";
    }

    /*************************/
    @RequestMapping("addaaa")
    @LogAnnotation("增加商品")
    public String addProduct(Product pro, HttpServletRequest request, @RequestParam MultipartFile[] filePath) {
        Images images = new Images();
        proSer.add(pro);
        //System.out.println(filePath.length);
        if (filePath.length > 0) {
            for (int i = 0; i < filePath.length; i++) {
                try {
                    InputStream inputStream = filePath[i].getInputStream();
                    //获取文件名
                    String originalFilename = filePath[i].getOriginalFilename();
                    //获取真实路径
                    String realPath = request.getServletContext().getRealPath(Gloable.SYSTEM_IMAGESPATH);
                    String path = FileUtil.copyFile(inputStream, originalFilename, realPath);
                    images.setProductId(pro.getId());
                    images.setImagePath(Gloable.SYSTEM_IMAGESPATH + path);
                    imagesService.add(images);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return "redirect:queryList.jhtml";
    }

    /**
     * @Description: 查询图片
     * @Author: ShangDongHai q540662261@126.com
     * @CreateDate: 2019/2/17 23:22
     * @UpdateUser: Shangdonghai
     * @UpdateDate: 2019/2/17 23:22
     * @UpdateRemark: 修改内容
     * @Version: 1.0
     */
    @RequestMapping("queryImages")
    public String queryImages(ModelMap map, Integer id) {
        List<Images> imagesList = proSer.queryImages(id);
        map.put("imagesList", imagesList);
        return "product/images";
    }

    /**
     * @Description: 删除图片
     * @Author: ShangDongHai q540662261@126.com
     * @CreateDate: 2019/2/18 7:53
     * @UpdateUser: Shangdonghai
     * @UpdateDate: 2019/2/18 7:53
     * @UpdateRemark: 修改内容
     * @Version: 1.0
     */
    @RequestMapping("deleteImage")
    public String deleteImage(Integer id) {
        imagesService.deleteImagePath(id);
        return "product/images";
    }

    /**
     * <pre>queryProductList(查询全部)
     * 创建人：ShangDongHai q540662261@126.com
     * 创建时间：2018年12月25日 下午6:31:04
     * 修改人：ShangDongHai q540662261@126.com
     * 修改时间：2018年12月25日 下午6:31:04
     * 修改备注：
     * @param map
     * @return</pre>
     */

    @RequestMapping("queryList")
    @ResponseBody
    public ServerResponse queryProductList(HttpServletRequest req,
                                ModelMap map,
                                Integer draw,
                                Integer start,
                                Integer length,
                                Product product) {
        //前台传过来的map集合可以用request.getgetParameterMap();接收
        //获取所有请求的参数
        Map<String, String[]> stringMap = req.getParameterMap();
        //System.out.println(stringMap);
        //前台传过来的值和数据库的字段不一致时 可以用map转换
        Map fildeMapping=new HashMap();
        //构建dataTable所需要的数据
        DataTableResult result = proSer.buildProductDataTable(req, draw, start, length, product, stringMap, fildeMapping);
        //返回结果到前台
        return ServerResponse.success(result);

    }


    /**
     * @Description: 跳转至查询页面
     * @Author: ShangDongHai q540662261@126.com
     * @CreateDate: 2019/2/28 14:43
     * @UpdateUser: Shangdonghai
     * @UpdateDate: 2019/2/28 14:43
     * @UpdateRemark: 修改内容
     * @Version: 1.0
     */
    @RequestMapping("toProductList")
    public String toProductList() {
        return "product/productList";
    }

    /**
     * <pre>deleteProduct(单个删除)
     * 创建人：ShangDongHai q540662261@126.com
     * 创建时间：2018年12月25日 下午6:38:30
     * 修改人：ShangDongHai q540662261@126.com
     * 修改时间：2018年12月25日 下午6:38:30
     * 修改备注：
     * @param id
     * @return</pre>
     */
    @RequestMapping("deleteProduct")
    @ResponseBody
    @LogAnnotation("删除单个商品")
    public ServerResponse deleteProduct(Integer id, HttpServletResponse response) {
        proSer.deleteProduct(id);
        return ServerResponse.success();
    }

    /**
     * <pre>deleteAll(批量删除)
     * 创建人：ShangDongHai q540662261@126.com
     * 创建时间：2018年12月25日 下午7:39:31
     * 修改人：ShangDongHai q540662261@126.com
     * 修改时间：2018年12月25日 下午7:39:31
     * 修改备注：
     * @param ids
     * @return</pre>
     */
    @RequestMapping("deleteAll")
    @ResponseBody
    @LogAnnotation("批量删除商品")
    public ServerResponse deleteAll(String ids, HttpServletResponse response) {
        proSer.deleteAll(ids);

        return ServerResponse.success();

    }

    /**
     * <pre>findPrdouct(修改回显)
     * 创建人：ShangDongHai q540662261@126.com
     * 创建时间：2018年12月26日 下午2:35:20
     * 修改人：ShangDongHai q540662261@126.com
     * 修改时间：2018年12月26日 下午2:35:20
     * 修改备注：
     * @param id
     * @return</pre>
     */
    @RequestMapping("findProduct")
    public ModelAndView findPrdouct(Integer id) {
        ModelAndView modelAndView = new ModelAndView("/product/update");
        Product product = proSer.findProduct(id);
        modelAndView.addObject("product", product);
        List<Brand> queryList = brandService.queryList();
        //把查询出来的数据传给queryList  传递到前台
        modelAndView.addObject("queryList", queryList);
        List<Images> imagesList = proSer.queryImages(id);
        modelAndView.addObject("imagesList", imagesList);
        return modelAndView;
    }

    /**
     * <pre>update(修改)
     * 创建人：ShangDongHai q540662261@126.com
     * 创建时间：2018年12月28日 下午2:02:17
     * 修改人：ShangDongHai q540662261@126.com
     * 修改时间：2018年12月28日 下午2:02:17
     * 修改备注：
     * @param product
     * @return</pre>
     */
    @RequestMapping("update")
    @LogAnnotation("修改商品")
    public String update(@RequestParam MultipartFile[] productImageUrl, Product product, @RequestParam MultipartFile productImagePath, HttpServletRequest request) {
        //判断路径url是否为空
        if (StringUtils.isNotEmpty(product.getPathUrl())) {
            ArrayList list = new ArrayList<>();
            String[] split = product.getPathUrl().split(",");
            for (String urls : split) {
                list.add(urls);
                //删除图片在本地的绝对路径
                String Path = request.getServletContext().getRealPath(urls);
                //String filePath=Path+product.getProductImage();
                File file = new File(Path);
                if (file.exists()) {
                    file.delete();
                }
            }
            //删除数据库的图片
            imagesService.deleteImageList(list);
        }


        //如果前台传过来图片就执行删除图片并更新图片
        if (productImagePath.getSize() > 0) {
            //删除图片在本地的绝对路径
            String Path = request.getServletContext().getRealPath(product.getProductImage());
            //String filePath=Path+product.getProductImage();
            File file = new File(Path);
            if (file.exists()) {
                file.delete();
            }
            //更新图片
            try {
                //获取输入流
                InputStream inputStream = productImagePath.getInputStream();
                //获取文件名字
                String originalFilename = productImagePath.getOriginalFilename();
                //获取文件的绝对路径
                String realPath = request.getServletContext().getRealPath(Gloable.SYSTEM_IMAGESPATH);
                String path = FileUtil.copyFile(inputStream, originalFilename, realPath);
                //将信息存入数据库
                product.setProductImage(Gloable.SYSTEM_IMAGESPATH + path);
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
        //图片增加
        System.out.println(productImageUrl.length);
        Images images = new Images();
        if (productImageUrl.length > 1) {
            for (int i = 0; i < productImageUrl.length; i++) {
                if (productImageUrl.length > 0) {
                    try {
                        InputStream inputStream = productImageUrl[i].getInputStream();
                        //获取文件名
                        String originalFilename = productImageUrl[i].getOriginalFilename();
                        //获取真实路径
                        String realPath = request.getServletContext().getRealPath(Gloable.SYSTEM_IMAGESPATH);
                        String path = FileUtil.copyFile(inputStream, originalFilename, realPath);
                        images.setImagePath(Gloable.SYSTEM_IMAGESPATH + path);
                        images.setProductId(product.getId());
                        imagesService.add(images);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }

            }
        }


        //把信息保存到数据库
        proSer.update(product);
        return "redirect:queryList.jhtml";
    }
}
