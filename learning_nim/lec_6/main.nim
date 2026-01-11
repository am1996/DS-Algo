import sequtils,sugar
import winim

proc filterer(numbers: seq[int] | array[4, int], predicate: (int)-> bool): seq[int] =
    var r: seq[int] = @[]
    for num in numbers:
        if predicate(num):
            r.add(num)
    return r

proc main()=
    let numbers: seq[int] = @[1,2,3,4]
    let oddNumbers = filterer(numbers, (x:int)->bool => x mod 2 != 0)
    echo oddNumbers
    let nimm: array[4, int] = [1,2,3,4]
    let oddNim = filterer(nimm, (x)=> x mod 2 != 0)
    echo oddNim
    let isLowerCase = {'A'..'Z'}
    echo isLowerCase
if isMainModule:
    main()