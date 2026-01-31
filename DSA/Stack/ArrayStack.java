import java.util.ArrayList;

public class ArrayStack {
    private Object arr[];
    private int size = 0;

    public ArrayStack(int capacity) {
        arr = new Object[capacity];
    }

    public int size() {
        return size;
    }

    public Object peak() {
        if (size == 0) {
            throw new IllegalStateException();
        }
        return arr[size - 1];
    }

    public Object pop() {
        if (size == 0) {
            throw new IllegalStateException();
        }
        Object temp = arr[--size];
        arr[size] = null;
        return temp;
    }

    public void push(Object obj) {
        if (size == arr.length) {
            resize();
        }
        arr[size++] = obj;
    }

    private void resize() {
        Object[] temp = arr;
        arr = new Object[2 * arr.length];
        System.arraycopy(temp, 0, arr, 0, size);
    }

    public void dltBottom() {
        if (size == 0) throw new IllegalStateException();
        for (int i = 0; i < size - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr[--size] = null;
    }

    public void dlt2ndlast() {
        if (size < 2) throw new IllegalStateException();
        Object temp = arr[size-1];
        pop();
        pop();
        push(temp);
    }

    public ArrayList<Integer> search(Object obj) {
        ArrayList<Integer> search = new ArrayList<>();
        for (int i = 0; i < size; i++) {
            if (arr[i].equals(obj))                {
                search.add(i);
            }
        }
        return search;
    }

    public boolean compare(ArrayStack a) {
        if (this.size != a.size) {
            return false;
        }
        for (int i = 0; i < this.size; i++) {
            if (!(this.arr[i].equals(a.arr[i]))) {
                return false;
            }
        }
        return true;
    }

    public LinkedStack toLinkedStack() {
        int s = this.size;
        Object[] x = new Object[s];
        LinkedStack y = new LinkedStack();
        for (int i = 0; i < s; i++) {
            x[i] = this.pop();
        }
        for (int i = s - 1; i >= 0; i--) {
            y.push(x[i]);
        }
        return y;
    }

    public static void main(String[] args) {
        ArrayStack books1 = new ArrayStack(5);
        ArrayStack books2 = new ArrayStack(5);
        ArrayStack books3 = new ArrayStack(5);
        books1.push(new Book("jkp", 2012));
        books1.push(new Book("Namal", 2017));
        books2.push(new Book("jkp", 2012));
        books2.push(new Book("Namal", 2017));
        books3.push(new Book("Harry Potter", 1997));
        books3.push(new Book("Silent Patient", 2019));
        System.out.println(books1.compare(books2));
        System.out.println(books1.compare(books3));
    }
}

class Book {
    private String name;
    private int pubDate;

    Book(String name, int pubDate) {
        this.name = name;
        this.pubDate = pubDate;
    }

    public boolean equals(Object obj) {
        if(obj == null || obj.getClass() != getClass()) return false;
        Book b1 = (Book)obj;
        if (this == b1)
            return true;
        if (this.name.equals(b1.name) && this.pubDate == b1.pubDate )
            return true;
        return false;
    }

}
