import org.junit.*;

public class TestDemo {
    @Test
    public void addTest(){
        System.out.println("==========addTest"); }
    @BeforeClass
    public static void updateTest(){
        System.out.println("==========updateTest"); }
    @After
    public void delTest(){
        System.out.println("==========delTest"); }
    @AfterClass
    public static void delTestInfo(){
        System.out.println("==========delTestInfo"); }
    public void addTestInfo(){
        System.out.println("==========addTestInfo"); }
    @Before
    public void updateTestInfo(){
        System.out.println("==========updateTestInfo"); }
    @Test
    public void queryTestInfo(){
        System.out.println("==========queryTestInfo"); }
}
