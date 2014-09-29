class A {
    private int x;
    public void setX(int n) { x = n; }
    public int getX() { return x; }
}

class TestParam {
    public static void main(String[] args) {
        A a = new A();
        System.out.println("a.x = " + a.getX());
        changeA(a);
        System.out.println("a.x = " + a.getX());
    }
    public static void changeA(A a) {
        a.setX(88);
    }
}
