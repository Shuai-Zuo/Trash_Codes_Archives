import decrypt
import encrypt
import renamer
import sys
import os
def main():
    rootdir = os.path.dirname(sys.argv[0])
    if os.path.exists(os.path.join(rootdir,"key.data")):
        if os.path.exists(os.path.join(rootdir,"FilenameList")):
            de = decrypt.Codingfile()
            de.file_full_decoding(os.path.join(rootdir,"FilenameList"))
            de.dir_decoding(rootdir)
            renamer.nameUnconfFolder(rootdir)
            os.remove(os.path.join(rootdir,"FilenameList"))
            os.remove(os.path.join(rootdir,"key.data"))
        else:
            print("Cannot Find file \"FilenameList\"")
    else:
        if os.path.exists(os.path.join(rootdir,"FilenameList")):
            print("Cannot Find file \"key.data\"")
        else:
            en = encrypt.Codingfile()
            en.dir_encoding(rootdir)
            renamer.nameConfFolder(rootdir)
            en.file_full_encoding(os.path.join(rootdir,"FilenameList"))



if __name__=='__main__':
    main()
