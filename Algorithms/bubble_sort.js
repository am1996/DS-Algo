function bblsort(a){
    let swapped = true;
    
    while(swapped){
        swapped = false;
        for(let i=0;i<a.length;i++){
            if(a[i]>a[i+1]){
                let temp = a[i];
                a[i] = a[i+1];
                a[i+1] = temp;
                swapped = true
            }
        }
    }
    return a;
}