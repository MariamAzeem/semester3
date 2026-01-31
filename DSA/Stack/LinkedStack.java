public class LinkedStack {
    private Node top;
    private int size = 0;

    private class Node {
        Object obj;
        Node next;
    
        public Node(Object obj, Node next) {
            this.obj = obj;
            this.next = next;
        }
    }
    

    public int size() {
        return size;
    }

    public void push(Object obj) {
        size++;
        top = new Node(obj, top);
    }

    public Object peek() {
        if (size == 0) {
            throw new IllegalStateException();
        }
        return top.obj;
    }

    public Object pop() {
        if (size == 0) {
            throw new IllegalStateException();
        }
        Object temp = top.obj;
        top = top.next;
        --size;
        return temp;
    }

    public boolean search(Object obj){
        if(size == 0){
            return false;
        }
        for(Node p = top; p != null; p = p.next){
            if(p.obj == null) continue;
            else if(p.obj.equals(obj)){
                return true;
            }
        }
        return false;
    }

    public ArrayStack toArrayStack() {
        int s = this.size;
        Object[] x = new Object[s];
        ArrayStack y = new ArrayStack(s);
        for (int i = 0; i < s; i++) {
            x[i] = this.pop();
        }
        for (int i = s - 1; i >= 0; i--) {
            y.push(x[i]);
        }
        return y;
    }

    public static void main(String[] args) {
        LinkedStack l = new LinkedStack();

        l.push("X");
        l.push("Y");
        l.push("Z");

        ArrayStack a = l.toArrayStack();

        System.out.println(a.pop()); // Z
        System.out.println(a.pop()); // Y
        System.out.println(a.pop()); // X
    }
}