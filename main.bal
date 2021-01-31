import ballerina/io;
import matrix_op_2.matop;

function (any[], any[]) returns boolean equalArrays = matop:equalArrays;

public function main() {
    // matop:Cell[] col = [{owner: "O"}, {owner: "_"}, {owner: "_"}, {owner: "_"}, {owner: "_"}, {owner: "O"}];
    // int leng = 3;

    // int i = 0;
    // while (i < col.length()) {
    //     // io:println(matop:hasOwner(col[i]));
    //     i = i + 1;
    // }
    // io:println(matop:cellAvailableOptions(leng, col));
    int[][] xsy = [[1, 2, 3], [5, 6, 7], [14, 15, 16]];
    int[][] ysx = [[0, 1, 2], [5, 6, 7], [14, 15, 16]];
    io:println(matop:intersectionArrays(xsy, ysx));
}
