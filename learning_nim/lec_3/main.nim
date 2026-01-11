
proc helloworld[T](value: T): T {.discardable.}= 
    result = value
    echo result
    return result

helloworld("Hello, World!")