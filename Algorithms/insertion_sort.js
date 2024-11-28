var arr = [5,1,8,9,3];
var n   = 5;

function insertion_sort(arr,n){
    for(let i=1;i<n;i++){
        let key = arr[i];
        let j = i-1;
        while(j>=0 && key < arr[j]){
            arr[j+1] = arr[j];
            --j;
        }
        arr[j+1] = key
    }
    return arr;
}
insertion_sort(arr,n);