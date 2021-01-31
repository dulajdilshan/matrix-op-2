// import ballerina/io;

public type Cell record {
    string owner;
};

public function hasOwner(Cell cell) returns boolean {
    return cell.owner != "_";
}

public function equalArrays(any[] arr1, any[] arr2) returns boolean {
    if (arr1.length() != arr2.length()) {
        return false;
    }

    int i = 0;
    while (i < arr1.length()) {
        if (arr1[i] !== arr2[i]) {
            return false;
        }
        i = i + 1;
    }

    return true;
}

public function getAvailableCells(int length, Cell[] col) returns int[] {
    int[] cells = [];
    int len = length;

    int i = 0;
    while (i < col.length()) {
        if (len == 0) {
            return cells;
        }

        Cell el = col[i];
        if (hasOwner(el)) {
            cells = [];
            len = length;
            i = i + 1;
            continue;
        }
        if (!hasOwner(el)) {
            len = len - 1;
            if (cells.length() == 0) {
                cells[0] = i;
            } else {
                cells[cells.length()] = i;
            }
        }
        i = i + 1;
    }

    if (len == 0) {
        return cells;
    }

    return [];
}

public function cellAvailableOptions(int len, Cell[] col) returns int[][]{
    int[][] cellOptions = [];

    int i = 0;
    while (i + len - 1 < col.length()) {
        Cell[] subcol = col.slice(i, i + len);
        int[] options = getAvailableCells(len, subcol);
        if (options.length() < 1) {
            i = i + 1;
            continue;
        }

        int[] opt = [];
        foreach int el in options {
            opt[opt.length()] = el + i;
        }

        cellOptions[cellOptions.length()] = opt;

        i = i + 1;
    }

    return cellOptions;
}

public function genNumberArrayForeach(int length) returns int[] {
    int[] ints = [];
    int i = 0;
    while (i < length) {
        ints[ints.length()] = i;
        i = i + 1;
    }
    return ints;
}

public function intersectionArrays(int[][] arr1, int[][] arr2) returns int[][]{     // Need optimization
    int[][] inter = [];
    int[] intsArr1 = genNumberArrayForeach(arr1.length());
    int[] intsArr2 = genNumberArrayForeach(arr2.length());
    foreach int i in intsArr1 {
        int[] arr1_in = arr1[i];
        foreach int j in intsArr2 {
            int[] arr2_in = arr2[j];
            if (equalArrays(arr1_in, arr2_in)) {
                inter[inter.length()] = arr1_in;
                break;
            }
        }
    }
    return inter;
}

public function getAvailableSpace(int width, int length, Cell[][] matrix) returns int[][]{
    int i = 0;
    int w =  width;
    int[][] options = [];
    int[][] prevOptions = [];
    int[] goodCols = [];
    while (i < matrix.length()) {
        if (w == 0) {
            return options;
        }

        int[][] cellOptions = cellAvailableOptions(length, matrix[i]);
        
        if (cellOptions.length() < 1) {
            i = i + 1;
            w = width;
            options = [];
            prevOptions = []; // *
            continue;
        }

        prevOptions = cellOptions;

        if (options.length() < 1) {
            options = cellOptions;
            i = i + 1;
            w = w - 1;
            continue;
        }

        // options.length() > 0 AND cellOptions.length() > 0
        // Need to check for intersection
        int[][] inter = intersectionArrays(options, cellOptions);
        if (inter.length() < 1) {
            
        }

        i = i + 1;
        
    }

    return options;
}
