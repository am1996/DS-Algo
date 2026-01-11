import sequtils,sugar
import winim

proc main()=
    let numbers: seq[int] = @[1,2,3,4]
    let oddNumbers = filter(numbers, (x:int)->bool => x mod 2 != 0)
    echo oddNumbers
    let nimm: array[4, int] = [1,2,3,4]
    let oddNim = filter(nimm, (x)=> x mod 2 != 0)
    echo oddNim
if isMainModule:
    main()