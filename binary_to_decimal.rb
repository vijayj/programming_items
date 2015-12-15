
def baseConverter(decNumber,base)
    digits = "0123456789ABCDEF"

    remstack = Array.new()

    while decNumber > 0
        rem = decNumber % base
        remstack.push(rem)
        decNumber = decNumber / base
    end

    newString = ""
    while not remstack.empty?
        newString = newString + digits[remstack.pop()]
    end

    return newString
end

p baseConverter(25,2)
p baseConverter(25,16)

