#raw = "g fmnc wms bgblr rpylqjyrc gr zw fylb. rfyrq ufyr amknsrcpq ypc dmp. bmgle gr gl zw fylb gq glcddgagclr ylb rfyr'q ufw rfgq rcvr gq qm jmle. sqgle qrpgle.kyicrpylq() gq pcamkkclbcb. lmu ynnjw ml rfc spj."
raw = "map"
ret = ""
for cha in raw:
    if ord(cha) >= ord("a") and ord(cha) <= ord("z"):
        ret += chr((ord(cha) - ord("a") + 2) % 26 + ord("a"))
    elif ord(cha) >= ord("A") and ord(cha) <= ord("Z"):
        ret += chr((ord(cha) - ord("A") + 2) % 26 + ord("A"))
    else:
        ret += cha
print(ret)