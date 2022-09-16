import decrypt
import encrypt
import sys
if __name__=='__main__':
    if len(sys.argv) != 3:
        print("Please use like {} encode/decode E:\\filename.txt".format(sys.argv[0]))
        sys.exit(1)
    
    if sys.argv[1]!='decode' and sys.argv[1]!='encode':
        print("Please use like {} encode/decode E:\\filename.txt".format(sys.argv[0]))
        sys.exit(1)

    if sys.argv[1] == "decode":
        decrypt.main()
    else:
        encrypt.main()
    sys.exit(0)