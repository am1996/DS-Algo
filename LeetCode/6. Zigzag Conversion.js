/**
 * @param {string} s
 * @param {number} numRows
 * @return {string}
 */
var convert = function(s, numRows) {
    if(numRows===1 || s.length<=numRows) return s;

    let currentRow=0;
    let rows = new Array(numRows).fill("");
    let goingDown= false;

    for(let c of s){
        rows[currentRow]+= c;

        if(currentRow===0 || currentRow === numRows-1){
            goingDown = ! goingDown;
        }
        currentRow += goingDown? 1: -1;
    }
    return rows.join('');
};
