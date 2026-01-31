class CostGraph {
    int size;
    String[] vertices;
    boolean[][] a; // adjacency matrix
    int[][] b; //cost adjecency matrix

    public CostGraph(String[] args) {
        size = args.length;
        vertices = new String[size];
        System.arraycopy(args, 0, vertices, 0, size);
        a = new boolean[size][size];
        b = new int[size][size];
    }

    public void add(String v, String w, int cost) {
        int i = index(v), j = index(w);
        a[i][j] = a[j][i] = true;
        b[i][j] = b[j][i] = cost;
    }

    public void delete(String v, String w) {
        int i = index(v), j = index(w);
        a[i][j] = a[j][i] = false;
        b[i][j] = b[j][i] = 0;
    }

    public String toString() {
        if (size == 0) return "";
    
        StringBuilder buf = new StringBuilder("{\n");
        for (int i = 0; i < size; i++) {
            buf.append(vertex(i)).append("\n");
        }
        buf.append("}");
        return buf.toString();
    }

    private int index(String v) {
        for (int i = 0; i < size; i++)
            if (vertices[i].equals(v)) return i;
        return a.length;
    }

    private String vertex(int i) {
        StringBuilder buf = new StringBuilder(vertices[i] + ": ");
        boolean first = true;
    
        for (int j = 0; j < size; j++) {
            if (a[i][j]) {
                if (!first) buf.append(", ");
                buf.append(vertices[j] + "(" + b[i][j] + ")");
                first = false;
            }
        }
    
        return buf.toString();
    }

    public static void main(String[] args) {
        String[] v = {"A", "B", "C", "D", "E"};
        CostGraph g = new CostGraph(v);

        g.add("A", "B",6);
        g.add("A", "C",4);
        g.add("B", "C",10);
        g.add("B", "E",7);
        g.add("C", "D",15);
        g.add("E", "D",11);

        System.out.println(g);
    }
}
